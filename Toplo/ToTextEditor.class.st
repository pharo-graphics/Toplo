"
My responsibility is to provide operations to act on the text.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	attachedElements:		<Object>
	cursors:		<Object>
	filter:		<Object>
	history:		<Object>
	isFocused:		<Object>
	mode:		<Object>
	model:		<Object>
	segmentBuilder:		<Object>
	segmentCollector:		<Object>
	selection:		<Object>
	selectionRecorder:		<Object>
	shortcuts:		<Object>
	shouldStyleWhenTextModified:		<Object>
	styler:		<Object>
	stylerEventHandler:		<Object>
	stylerStrategy:		<Object>
	text:		<Object>


    Implementation Points
"
Class {
	#name : #ToTextEditor,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'model',
		'mode',
		'text',
		'selection',
		'selectionRecorder',
		'segmentBuilder',
		'segmentCollector',
		'styler',
		'stylerStrategy',
		'stylerEventHandler',
		'cursors',
		'attachedElements',
		'history',
		'filter',
		'shortcuts',
		'isFocused',
		'shouldStyleWhenTextModified'
	],
	#classInstVars : [
		'isDebug'
	],
	#category : #'Toplo-Editor-Model'
}

{ #category : #cleanup }
ToTextEditor class >> cleanUp [
	super cleanUp.
	
	isDebug := nil
]

{ #category : #accessing }
ToTextEditor class >> isDebug [
	^ isDebug ifNil: [ false ]
]

{ #category : #accessing }
ToTextEditor class >> isDebug: aBoolean [
	isDebug := aBoolean
]

{ #category : #'api - shortcuts' }
ToTextEditor >> addEditorShortcut: aBrTextEditorShortcut [
	self editorShortcuts
		add: aBrTextEditorShortcut
		ifAdded: [ :aNewEditorShortcut | self onShortcutAdded: aNewEditorShortcut ]
		ifReplaced: [ :aPreviousEditorShortcut | self onShortcutRemoved: aPreviousEditorShortcut ]
]

{ #category : #'api - shortcuts' }
ToTextEditor >> addEditorShortcuts: aCollectionOfBrTextEditorShortcut [
	aCollectionOfBrTextEditorShortcut
		do: [ :eachShortcut | self addEditorShortcut: eachShortcut ]
]

{ #category : #asserting }
ToTextEditor >> assertUIProcess [
	"I check if the current process is a UI process of all attached editor elements"
	| aCurrentProcess allUIProcesses |
	
	aCurrentProcess := Processor activeProcess.	
	allUIProcesses := self uiProcesses.
	
	(allUIProcesses size <= 1)
		ifFalse: [ BrEditorWrongThreadError signal: 'The editor is attached to multiple elements from different UI processes' ].
		
	(allUIProcesses isEmpty or: [ allUIProcesses anyOne == aCurrentProcess ])
		ifFalse: [ BrEditorWrongThreadError signal: ('I am running from a non-UI process ({1}) expected ({2})'
				format: { aCurrentProcess asString . allUIProcesses anyOne asString }) ].
]

{ #category : #'api - mode' }
ToTextEditor >> beEditable [
	self editorMode: BrTextEditorEditableMode new
]

{ #category : #'api - mode' }
ToTextEditor >> beEditableCode [
	self editorMode: BrTextEditorEditableCodeMode new
]

{ #category : #accessing }
ToTextEditor >> beLineBased [
	segmentBuilder := BrTextEditorLineSegmentBuilder new splitter: BrTextEditorLineSplitter new
]

{ #category : #accessing }
ToTextEditor >> beParagraphBased [
	segmentBuilder := BrTextEditorLineSegmentBuilder new splitter: BrTextEditorParagraphSplitter new
]

{ #category : #'api - mode' }
ToTextEditor >> beReadOnlyWithSelection [
	self editorMode: BrTextEditorReadonlyWithSelectionMode new
]

{ #category : #'api - mode' }
ToTextEditor >> beReadOnlyWithoutSelection [
	self editorMode: BrTextEditorReadonlyWithoutSelectionMode new
]

{ #category : #'private - selection' }
ToTextEditor >> commitSelection [
	self selectionRecorder commit: self
]

{ #category : #'text - copy/paste' }
ToTextEditor >> copy: aFromIndex to: aToIndex [
	"Copy text within given text interval to the clipboard"
	
	Clipboard clipboardText: (self text from: aFromIndex + 1 to: aToIndex) asString
]

{ #category : #'text - copy/paste' }
ToTextEditor >> copySelected [
	"Copy currently selected text to the clipboard"
	
	self selection isEmpty
		ifTrue: [ ^ self ].
		
	self
		copy: self selection from
		to: self selection to
]

{ #category : #accessing }
ToTextEditor >> cursor [
	<return: #BrTextEditorCursor>

	self
		deprecated: 'Use #cursors instead.'
		transformWith: '`@receiver cursor' -> '`@receiver cursors'.

	^ cursors
]

{ #category : #accessing }
ToTextEditor >> cursors [
	<return: #BrTextEditorCursor>

	^ cursors
]

{ #category : #'text - copy/paste' }
ToTextEditor >> cut: aFromIndex to: aToIndex [
	"Copy text within given text interval to the clipboard and remove it from the editor.
	Note: I update the cursor location and selection"

	self copy: aFromIndex to: aToIndex.

	self selectNone.
	self moveCursorTo: aFromIndex.
	self delete: aFromIndex to: aToIndex
]

{ #category : #'text - copy/paste' }
ToTextEditor >> cutSelected [
	"Copy currently selected text to the clipboard and remove it from the editor.
	Note: I update the cursor location and selection"
	
	self selection isEmpty
		ifTrue: [ ^ self ].
	
	self
		cut: self selection from
		to: self selection to
]

{ #category : #initialization }
ToTextEditor >> defaultCursors [
	<return: #BrTextEditorCursor>

	^ BrTextEditorMultipleCursor new
]

{ #category : #initialization }
ToTextEditor >> defaultSegmentBuilder [
	^ BrTextEditorLineSegmentBuilder new
]

{ #category : #initialization }
ToTextEditor >> defaultSegmentCollector [
	^ BrTextEditorSegmentCollector new
]

{ #category : #initialization }
ToTextEditor >> defaultSelection [
	<return: #BlSelection>

	^ BlCompositeSelection new
]

{ #category : #initialization }
ToTextEditor >> defaultSelectionRecorder [
	<return: #BrTextEditorSelectionRecorder>

	^ BrTextEditorSelectionOverwriteRecorder new
]

{ #category : #initialization }
ToTextEditor >> defaultStyler [
	^ BlTextNullStyler new
]

{ #category : #initialization }
ToTextEditor >> defaultStylerEventHandler [
	^ BlEventHandler
		on: BrTextStyledEvent
		do: [ :anEvent | self onTextStyled: anEvent ]
]

{ #category : #initialization }
ToTextEditor >> defaultStylerStrategy [
	^ BrTextStylerSyncStrategy new
]

{ #category : #initialization }
ToTextEditor >> defaultText [
	<return: #BlText>
	^ BlRopedText string: ''
]

{ #category : #'private - text' }
ToTextEditor >> delete: aFromTextIndex to: aToTextIndex [
	"I delete a piece of text within a given text interval without cursor or selection update.
	Note: cursor or selection location after deletion may be invalid!"

	self deleter
		from: aFromTextIndex to: aToTextIndex;
		withoutCursorUpdate;
		withoutSelectionUpdate;
		delete
]

{ #category : #'api - modification' }
ToTextEditor >> deleter [
	^ BrTextEditorDeleter new editor: self
]

{ #category : #'private - text' }
ToTextEditor >> deselect: aFromTextIndex to: aToTextIndex [
	"Deselect text within an interval defined by provided from and to indices without any other side effects.
	Note:
		- I don't change cursor position.
		- I request segments update"

	self deselecter
		from: aFromTextIndex to: aToTextIndex;
		deselect
]

{ #category : #'api - modification' }
ToTextEditor >> deselecter [
	<return: #BrTextEditorDeselecter>

	^ BrTextEditorDeselecter new editor: self
]

{ #category : #'text - styling' }
ToTextEditor >> disableStyleTextWhenModified [
	shouldStyleWhenTextModified := false
]

{ #category : #'text - styling' }
ToTextEditor >> disableStyleTextWhenModifiedDuring: aBlock [
	| aPreviousShouldStyleWhenTextModified |
	
	aPreviousShouldStyleWhenTextModified := shouldStyleWhenTextModified.
	shouldStyleWhenTextModified := false.
	aBlock ensure: [ shouldStyleWhenTextModified := aPreviousShouldStyleWhenTextModified ]
]

{ #category : #'api - mode' }
ToTextEditor >> editorMode [
	<return: #BrTextEditorMode>

	^ mode
]

{ #category : #'api - mode' }
ToTextEditor >> editorMode: aBrTextEditorMode [
	self
		assert: [ aBrTextEditorMode isNotNil ]
		description: [ 'Mode must not be nil' ].

	mode = aBrTextEditorMode
		ifTrue: [ ^ self ].

	"Uninstall existing mode"
	mode uninstallFromEditor: self.
	attachedElements do: [ :eachElement | mode uninstallFromEditorElement: eachElement ].

	mode := aBrTextEditorMode.
	mode installOnEditor: self.
	attachedElements do: [ :eachElement | mode installOnEditorElement: eachElement ].
	
	self notifyChanged
]

{ #category : #'api - shortcuts' }
ToTextEditor >> editorShortcuts [
	<return: #BrTextEditorShortcuts>

	^ shortcuts
]

{ #category : #'text - styling' }
ToTextEditor >> enableStyleTextWhenModified [
	shouldStyleWhenTextModified := true
]

{ #category : #'commands - processing' }
ToTextEditor >> enqueueCommand: aBrTextEditorCommand [
	(BrTextEditorCommandSignal textEditor: self)
		command: aBrTextEditorCommand;
		emit.

	aBrTextEditorCommand executeOn: self
]

{ #category : #'commands - processing' }
ToTextEditor >> enqueueHolderCommand: aBrTextEditorHolderCommand interval: aTextInterval [
	(BrTextEditorHolderCommandSignal textEditor: self)
		command: aBrTextEditorHolderCommand;
		interval: aTextInterval;
		emit.

	self
		notifyItems: aTextInterval
		event: aBrTextEditorHolderCommand
]

{ #category : #'text - selection' }
ToTextEditor >> hasCursors [
	"Return true of there is at least one cursor, false otherwise"
	<return: #Boolean>
	
	^ self cursors isNotEmpty
]

{ #category : #'text - selection' }
ToTextEditor >> hasSelection [
	"Return true of there is at least one selected character, false otherwise"
	<return: #Boolean>
	
	^ self selection isNotEmpty
]

{ #category : #accessing }
ToTextEditor >> history [
	<return: #BrTextEditorHistory>
	
	^ history
]

{ #category : #accessing }
ToTextEditor >> history: aBrTextEditorHistory [
	history := aBrTextEditorHistory
]

{ #category : #initialization }
ToTextEditor >> initialize [
	super initialize.
	
	mode := BrTextEditorNullMode new.
	
	attachedElements := Set new.
	
	filter := BrTextEditorNoInputFilter new.
	cursors := self defaultCursors.
	selection := self defaultSelection.
	selectionRecorder := self defaultSelectionRecorder.
	
	text := self defaultText.
	self initializeText: text.
	
	segmentCollector := self defaultSegmentCollector.
	segmentCollector editor: self.
	segmentCollector text: text.
	segmentBuilder := self defaultSegmentBuilder.

	styler := self defaultStyler.
	stylerEventHandler := self defaultStylerEventHandler.
	self addEventHandler: stylerEventHandler.
	self useDefaultStylerStrategy.
	
	shortcuts := BrTextEditorShortcuts new.
	history := BrTextEditorHistory new.
	
	isFocused := false.
	shouldStyleWhenTextModified := true.

	self beEditable.
	"self beParagraphBased"
]

{ #category : #initialization }
ToTextEditor >> initializeText: aBrText [
	aBrText when: BlTextStringsInserted send: #onStringsInserted: to: self.
	aBrText when: BlTextsDeleted send: #onTextsDeleted: to: self.
	aBrText when: BlTextAttributeAdded send: #onTextAttributeAdded: to: self.
	aBrText when: BlTextAttributesRemoved send: #onTextAttributesRemoved: to: self.
]

{ #category : #'api - filter' }
ToTextEditor >> inputFilter [
	<return: #BrTextEditorInputFilter>

	^ filter
]

{ #category : #'api - filter' }
ToTextEditor >> inputFilter: aBrTextEditorInputFilter [
	filter := aBrTextEditorInputFilter
]

{ #category : #'private - text' }
ToTextEditor >> insertString: aString at: aTextIndex [

	self inserter
		at: aTextIndex;
		string: aString;
		withoutCursorUpdate;
		withoutSelectionUpdate;
		withoutSelectionDelete;
		insert
]

{ #category : #'api - modification' }
ToTextEditor >> inserter [
	^ BrTextEditorInserter new editor: self
]

{ #category : #accessing }
ToTextEditor >> isFocused [
	<return: #Boolean>

	^ isFocused
]

{ #category : #accessing }
ToTextEditor >> itemCount [
	^ segmentCollector computedSegmentsCount
]

{ #category : #accessing }
ToTextEditor >> itemIdAt: aPosition [
	^ (segmentCollector segmentAt: aPosition) index
]

{ #category : #accessing }
ToTextEditor >> itemTypeAt: aPosition [
	"Return segment type at a given position"
	<return: #BrEditorSegmentType>
	
	^ (segmentCollector segmentAt: aPosition) segmentType
]

{ #category : #accessing }
ToTextEditor >> model [
self flag: 'How the model is used ?'.
self halt.
	^ model
]

{ #category : #accessing }
ToTextEditor >> model: anObject [
self halt.
	model := anObject
]

{ #category : #'text - cursor' }
ToTextEditor >> moveCursorTo: aTextIndex [
	"Moves cursor to a given position without any further action such as cancelling selection"
	<event: #BrTextEditorCursorMovedEvent>

	self navigator
		moveTo: aTextIndex;
		apply
]

{ #category : #'api - modification' }
ToTextEditor >> navigator [
	^ BrTextEditorNavigator new editor: self
]

{ #category : #'commands - creation' }
ToTextEditor >> newFocusChangedCommand [
	^ BrTextEditorFocusChangedCommand new
]

{ #category : #'commands - creation' }
ToTextEditor >> newInvalidateCommand [
	^ BrTextEditorInvalidateCommand new
]

{ #category : #'commands - creation' }
ToTextEditor >> newSelectCommand [
	^ BrTextEditorSelectCommand new
]

{ #category : #'commands - creation' }
ToTextEditor >> newSelectionUpdateCommand [
	^ BrTextEditorSelectionUpdateCommand new
]

{ #category : #'commands - creation' }
ToTextEditor >> newUpdateCommand [
	^ BrTextEditorUpdateCommand new
]

{ #category : #'private - cursor' }
ToTextEditor >> notifyAttributesWithinCursor: aCollectionOfAttributes [
	"I select and notify those attributes in the given collection that are within any of the cursors"
	| theEventHandlingAttributes anEvent |
	
	self isFocused
		ifFalse: [ ^ self ].

	anEvent := BrTextCursorAttributeEnterEvent new.
	
	theEventHandlingAttributes := (aCollectionOfAttributes select: [ :eachAttribute | eachAttribute isEventHandler ]) asSet.
	
	self text
		findAttributesSuchThat: [ :eachAttribute | theEventHandlingAttributes includes:  eachAttribute ]
		indicesDo: [ :aStart :anEnd :eachAttribute |
			(self cursors anySatisfy: [ :eachCursor |
					eachCursor position between: aStart and: anEnd ])
						ifTrue: [
							anEvent interval: (aStart to: anEnd).
							(eachAttribute wantsEvent: anEvent in: self)
								ifTrue: [ eachAttribute handleEvent: anEvent in: self on: nil ] ] ]
]

{ #category : #'event firing' }
ToTextEditor >> notifyDeletedFrom: aFromIndex to: aToIndex [
	self dispatchEvent: (BrTextEditorDeletedEvent new
		editor: self;
		fromIndex: aFromIndex;
		toIndex: aToIndex)
]

{ #category : #'event firing' }
ToTextEditor >> notifyInserted: aText at: aTextIndex [
	self dispatchEvent: (BrTextEditorInsertedEvent text: aText at: aTextIndex)
]

{ #category : #'event firing' }
ToTextEditor >> notifyInteractionAdded: anInteraction [
	self dispatchEvent: (BrTextEditorInteractionAddedEvent new interaction: anInteraction)
]

{ #category : #'event firing' }
ToTextEditor >> notifyInteractionRemoved: anInteraction [
	self dispatchEvent: (BrTextEditorInteractionRemovedEvent new interaction: anInteraction)
]

{ #category : #'event firing' }
ToTextEditor >> notifyModified: aText [
	self dispatchEvent: (BrTextEditorModifiedEvent new text: aText)
]

{ #category : #'event firing' }
ToTextEditor >> notifySelectionChanged: aSelection [
	self dispatchEvent: (BrTextEditorSelectionChangedEvent new selection: aSelection)
]

{ #category : #'event firing' }
ToTextEditor >> notifyTextReplaced: aText [
	self dispatchEvent: (BrTextEditorTextReplacedEvent new text: aText)
]

{ #category : #'event firing' }
ToTextEditor >> notifyTextStyled: aText [
	self dispatchEvent: (BrTextEditorTextStyledEvent new styledText: aText)
]

{ #category : #hooks }
ToTextEditor >> onAttached: anEditorElement [
	super onAttached: anEditorElement.

	attachedElements := attachedElements copyWith: anEditorElement.

 	mode installOnEditorElement: anEditorElement.
	shortcuts do: [ :eachInteraction | self onInteractionAdded: eachInteraction to: anEditorElement ].

	anEditorElement when: BlMouseUpEvent do: [ :anEvent | anEvent consumed: true ].
	anEditorElement when: BlClickEvent do: [ :anEvent | anEvent consumed: true ].
	anEditorElement when: BlFocusEvent do: [ self onGotFocus ].
	anEditorElement when: BlBlurEvent do: [ self onLostFocus ].

	self notifyChanged
]

{ #category : #'instance creation' }
ToTextEditor >> onBindHolder: aSegmentHolder at: aPosition [
	"I bind a segment at a given position to the provided segment holder"
	| aSegment previousLastIndex |

	"First we want to acquire a segment for a given position"
	aSegmentHolder infiniteElement telemetry
		timeSync: [ 'Get segment at {1}' format: { aPosition } ]
		during: [ aSegment := segmentCollector segmentAt: aPosition. ].

	"and then bind it to the holder"
	aSegmentHolder infiniteElement telemetry
		timeSync: [ 'Set segment at {1}' format: { aPosition } ]
		during: [ aSegmentHolder segment: aSegment ].

	"If the last cached segment was requested, load more so that the editor knows there are more lines"
	(aPosition = segmentCollector lastIndex and: [ segmentCollector end < segmentCollector text size ])
		ifTrue: [
			previousLastIndex := segmentCollector lastIndex.
			segmentCollector computeForwardAt: aPosition + 1.
			self notifyItemsInserted: (aPosition + 1 to: aPosition + segmentCollector lastIndex - previousLastIndex) ]
]

{ #category : #'instance creation' }
ToTextEditor >> onBindHolder: aSegmentHolder at: aPosition payloads: aCollectionOfPayloads [	
	"I bind a segment at a given position to provided segment holder"

	aCollectionOfPayloads
		ifEmpty: [ self onBindHolder: aSegmentHolder at: aPosition ]
		ifNotEmpty: [ :theCommands |
			theCommands do: [ :aHolderCommand | aHolderCommand executeOn: aSegmentHolder ] ]
]

{ #category : #'instance creation' }
ToTextEditor >> onCreateHolder: anEditorElement type: aSegmentType [
	"Create and return a new segment holder of a given type to be used with provided editor element"
	<return: #BrEditorSegmentHolder>
	
	"We perform a single dispatch on a segment type in order to support multiple types"
	^ aSegmentType holder
]

{ #category : #hooks }
ToTextEditor >> onDetached: anEditorElement [
	super onDetached: anEditorElement.

	attachedElements := attachedElements copyWithout: anEditorElement.

	mode uninstallFromEditorElement: anEditorElement.
	shortcuts do: [ :eachInteraction | self onInteractionRemoved: eachInteraction from: anEditorElement ].

	anEditorElement
		removeEventHandlersSuchThat: [ :aHandler | (aHandler isKindOf: BlEventHandler)
			and: [ { BlMouseUpEvent . BlClickEvent . BlFocusEvent . BlBlurEvent } includes: aHandler eventClass ] ]
]

{ #category : #hooks }
ToTextEditor >> onElementRecycled: anElementHolder [
	super onElementRecycled: anElementHolder.
	
	anElementHolder onRecycled
]

{ #category : #'private - focus' }
ToTextEditor >> onGotFocus [
	isFocused := true.
	
	self cursors isEmpty
		ifTrue: [ self navigator moveTo: 0; apply ].

	self processCursorAttributes.
	self enqueueCommand: (self newFocusChangedCommand hasFocus: true)
]

{ #category : #hooks }
ToTextEditor >> onInteractionAdded: anInteraction to: anEditorElement [
	anEditorElement removeShortcutsWithCombination: anInteraction combination.
	anEditorElement addShortcut: anInteraction asShortcut
]

{ #category : #hooks }
ToTextEditor >> onInteractionRemoved: anInteraction from: anEditorElement [
	anEditorElement removeShortcutsWithCombination: anInteraction combination
]

{ #category : #'private - focus' }
ToTextEditor >> onLostFocus [
	isFocused := false.

	self processCursorAttributes.
	self enqueueCommand: (self newFocusChangedCommand hasFocus: false).
]

{ #category : #hooks }
ToTextEditor >> onShortcutAdded: anInteraction [
	attachedElements do: [ :eachElement | self onInteractionAdded: anInteraction to: eachElement ].
	self notifyInteractionAdded: anInteraction
]

{ #category : #hooks }
ToTextEditor >> onShortcutRemoved: anInteraction [
	attachedElements do: [ :eachElement | self onInteractionRemoved: anInteraction from: eachElement ].
	self notifyInteractionRemoved: anInteraction
]

{ #category : #'hooks - text modifications' }
ToTextEditor >> onStringsInserted: aBlTextStringsInserted [
	"Is sent after a few strings (or one) are inserted in a text model"
	self assertUIProcess.
	
	aBlTextStringsInserted strings
		with: aBlTextStringsInserted finalIndices
		do: [ :aString :anIndex |
			self segmentBuilder
				insertedString: aString
				at: anIndex
				in: self ].

	history
		insertedStrings: aBlTextStringsInserted strings
		undo: aBlTextStringsInserted finalIndices
		redo: aBlTextStringsInserted requestedIndices.

	aBlTextStringsInserted strings
		with: aBlTextStringsInserted finalIndices
		do: [ :aString :anIndex |
			self
				notifyInserted: aString asRopedText
				at: anIndex ].

	self notifyModified: self text.

	shouldStyleWhenTextModified
		ifTrue: [ self styleText ]
]

{ #category : #'hooks - text modifications' }
ToTextEditor >> onTextAttributeAdded: aBlTextAttributeAdded [
	self assertUIProcess.

	self segmentBuilder
		addedAttribute: aBlTextAttributeAdded attribute
		from: aBlTextAttributeAdded fromIndex
		to: aBlTextAttributeAdded toIndex
		in: self.

	self notifyAttributesWithinCursor: { aBlTextAttributeAdded attribute }
]

{ #category : #'hooks - text modifications' }
ToTextEditor >> onTextAttributesRemoved: aBlTextAttributesRemoved [
	self assertUIProcess.

	self segmentBuilder
		removedAttributesFrom: aBlTextAttributesRemoved fromIndex
		to: aBlTextAttributesRemoved toIndex
		in: self.
]

{ #category : #'hooks - text modifications' }
ToTextEditor >> onTextReplaced [
	"Is sent after a text instance is replaced with a new one"
	self assertUIProcess.

	self processCursorAttributes.
	self notifyTextReplaced: self text
]

{ #category : #'hooks - text modifications' }
ToTextEditor >> onTextStyled: aBlTextStyledEvent [
	self assertUIProcess.
	
	(aBlTextStyledEvent text isNextGenerationOf: self text)
		ifTrue: [
			self text rope: aBlTextStyledEvent text text rope.
			
			aBlTextStyledEvent editorElement telemetry
				timeSync: [ 'Execute after-action: {1}' format: { aBlTextStyledEvent afterAction } ]
				during: [ aBlTextStyledEvent afterAction value: self text. ].
			
			aBlTextStyledEvent editorElement telemetry
				timeSync: [ 'notifyTextStyled' ]
				during: [ self notifyTextStyled: self text ].
			
			aBlTextStyledEvent editorElement telemetry
				timeSync: [ 'processCursorAttributes' ]
				during: [ self processCursorAttributes ].
			
			aBlTextStyledEvent editorElement telemetry
				timeSync: [ 'Invalidate the whole text editor due to text change' ]
				during: [
					self updater
						all;
						update ] ]
		ifFalse: [ self styleTextAndAfterDo: aBlTextStyledEvent afterAction ]
]

{ #category : #'hooks - text modifications' }
ToTextEditor >> onTextsDeleted: aBlTextsDeleted [
	"Is sent after a piece of text was deleted in a text model"
	self assertUIProcess.

	aBlTextsDeleted finalIntervals
		do: [ :eachInterval |
			self segmentBuilder
				deletedFrom: eachInterval first
				to:  eachInterval last
				in: self ].

	history
		"text attributes may reference objects such as computation results in the editor and therefore we
		should remove such attributes"
		deletedTexts: (aBlTextsDeleted texts collect: [ :eachText | eachText copyWithoutExternalReferences ])
		undo: (aBlTextsDeleted finalIntervals collect: #first)
		redo: (aBlTextsDeleted requestedIntervals collect: #first).

	aBlTextsDeleted finalIntervals
		do: [ :eachInterval |
			self
				notifyDeletedFrom: eachInterval first
				to:  eachInterval last ].

	self notifyModified: self text.
	
	shouldStyleWhenTextModified
		ifTrue: [ self styleText ]
]

{ #category : #'text - copy/paste' }
ToTextEditor >> paste [
	"A paste a text from the clipboard at the current cursor position.
	I delete any currently selected text and update cursor position"
	
	self paster
		fromClipboard;
		atCursor;
		paste
]

{ #category : #'api - modification' }
ToTextEditor >> paster [
	^ BrTextEditorPaster new editor: self
]

{ #category : #'private - selection' }
ToTextEditor >> prepareSelection [
	self selectionRecorder prepare: self
]

{ #category : #'private - cursor' }
ToTextEditor >> processCursorAttributes [
	"I search for the attributes within the whole text that contain (or not contain) any of the cursors and notify about it"

	| anEnteredEvent aLeavedEvent eventHandlingAttributesOutside eventHandlingAttributesInside |

	anEnteredEvent := BrTextCursorAttributeEnterEvent new.
	aLeavedEvent := BrTextCursorAttributeLeaveEvent new.

	eventHandlingAttributesOutside := OrderedDictionary new.
	eventHandlingAttributesInside := OrderedDictionary new.

	self text
		findAttributesSuchThat: [ :eachAttribute | eachAttribute isEventHandler ]
		indicesDo: [ :aStart :anEnd :anAttribute |
			((self isFocused and: [ self cursors anySatisfy: [ :eachCursor |
				eachCursor position between: aStart and: anEnd ] ])
					ifTrue: [ eventHandlingAttributesInside ]
					ifFalse: [ eventHandlingAttributesOutside ])
						at: anAttribute put: (aStart to: anEnd) ].

	eventHandlingAttributesOutside keysAndValuesDo: [ :eachAttribute :eachInterval |
		aLeavedEvent interval: eachInterval.
		(eachAttribute wantsEvent: aLeavedEvent in: self) ifTrue: [
			eachAttribute handleEvent: aLeavedEvent in: self on: nil ] ].

	eventHandlingAttributesInside keysAndValuesDo: [ :eachAttribute :eachInterval |
		anEnteredEvent interval: eachInterval.
		(eachAttribute wantsEvent: anEnteredEvent in: self) ifTrue: [
			eachAttribute handleEvent: anEnteredEvent in: self on: nil ] ]

]

{ #category : #'private - selection' }
ToTextEditor >> recordDeselection: aMonotoneTextSelection [
	self selectionRecorder deselect: aMonotoneTextSelection in: self.
	
	(self selection + self selectionRecorder selection) isEmpty
		ifTrue: [ ^ self ].
		
	self moveCursorTo: (self selection + self selectionRecorder selection) to
]

{ #category : #'private - selection' }
ToTextEditor >> recordSelection: aMonotoneTextSelection [
	self selectionRecorder select: aMonotoneTextSelection in: self.

	(self selection + self selectionRecorder selection) isEmpty
		ifTrue: [ ^ self ].
		
	self moveCursorTo: (self selection + self selectionRecorder selection) to
]

{ #category : #'text - undo/redo' }
ToTextEditor >> redo [
	history redoOn: self
]

{ #category : #'api - shortcuts' }
ToTextEditor >> removeAllEditorShortcuts [
	self editorShortcuts
		removeAllShortcutsAndDo: [ :aPreviousShortcut | self onShortcutRemoved: aPreviousShortcut ]
]

{ #category : #'api - shortcuts' }
ToTextEditor >> removeEditorShortcut: aBrTextEditorShortcut [
	self editorShortcuts
		remove: aBrTextEditorShortcut
		ifFound: [ :aPreviousShortcut | self onShortcutRemoved: aPreviousShortcut ]
]

{ #category : #'api - shortcuts' }
ToTextEditor >> removeEditorShortcuts: aCollectionOfBrTextEditorShortcut [
	aCollectionOfBrTextEditorShortcut do: [ :eachShortcut | self removeEditorShortcut: eachShortcut ]
]

{ #category : #'api - save state' }
ToTextEditor >> restoreState: aBrTextEditorMemento [
	self assertUIProcess.

	aBrTextEditorMemento restoreStateOf: self
]

{ #category : #accessing }
ToTextEditor >> restoreText: aBrText [
	"before changing the text we must unsubscribe from existing one"	
	text unsubscribe: self.

	text := aBrText.
	self initializeText: text.

	"Replacing text instance means that we can not guarantee structural integrity
	of existing cache and have to rebuild it invalidating the whole underlying model structure"
	segmentCollector := self defaultSegmentCollector.
	segmentCollector editor: self.
	segmentCollector text: text.

	self onTextReplaced.

	"notify UI about structural update"
	self notifyChanged.

	"text changed, we should style it"
	shouldStyleWhenTextModified
		ifTrue: [ self styleText ]
]

{ #category : #'api - save state' }
ToTextEditor >> saveState [
	<return: #BrTextEditorMemento>
	self assertUIProcess.
	
	^ (BrTextEditorCompositeMemento new all) saveStateOf: self
]

{ #category : #'api - save state' }
ToTextEditor >> saveState: aBrTextEditorMemento [
	<return: #BrTextEditorMemento>
	self assertUIProcess.
	
	^ aBrTextEditorMemento saveStateOf: self
]

{ #category : #accessing }
ToTextEditor >> segmentBuilder [
	<return: #BrTextEditorSegmentBuilder>

	^ segmentBuilder
]

{ #category : #accessing }
ToTextEditor >> segmentBuilder: aTextSegmentBuilder [
	"Change current segment builder to a new one and completely invalidate the structure"
	
	segmentBuilder := aTextSegmentBuilder.
	self notifyChanged
]

{ #category : #accessing }
ToTextEditor >> segmentBuilderDo: aBlock [
	aBlock value: segmentBuilder
]

{ #category : #accessing }
ToTextEditor >> segmentCollector [
	<return: #BrTextEditorSegmentCollector>

	^ segmentCollector
]

{ #category : #'private - text' }
ToTextEditor >> select: aFromTextIndex to: aToTextIndex [
	"Select text within an interval defined by provided from and to indices without any other side effects.
	Note:
		- I don't change cursor position.
		- I request segments update"

	self selecter
		from: aFromTextIndex to: aToTextIndex;
		withoutCursorUpdate;
		select
]

{ #category : #'text - selection' }
ToTextEditor >> selectNone [
	"Deselect the whole text in the editor without any other side effects.
	Note:
		- I don't change cursor position.
		- I request segments update"

	self selection isEmpty
		ifTrue: [ ^ self ].

	self
		deselect: self selection from
		to: self selection to
]

{ #category : #'text - selection' }
ToTextEditor >> selectedText [
	<return: #BlText>
	
	^ self hasSelection
		ifTrue: [ self text copyFrom: self selection from + 1 to: self selection to ]
		ifFalse: [ self text empty ]
]

{ #category : #'api - modification' }
ToTextEditor >> selecter [
	<return: #BrTextEditorSelecter>

	^ BrTextEditorSelecter new editor: self
]

{ #category : #accessing }
ToTextEditor >> selection [
	<return: #BlSelection>

	^ selection
]

{ #category : #'private - selection' }
ToTextEditor >> selection: aTextSelection [
	selection := aTextSelection.
	
	self notifySelectionChanged: selection
]

{ #category : #accessing }
ToTextEditor >> selectionRecorder [
	<return: #BrTextEditorSelectionRecorder>

	self
		assert: [ selectionRecorder isNotNil ]
		description: [ 'Selection recorder can not be nil' ].

	^ selectionRecorder
]

{ #category : #'api - shortcuts' }
ToTextEditor >> setEditorShortcuts: aBrTextEditorShortcuts [
	self
		assert: [ aBrTextEditorShortcuts isKindOf: BrTextEditorShortcuts ]
		description: [ 'Must be an editor shortcuts object' ].
	
	self removeAllEditorShortcuts.
	
	shortcuts := aBrTextEditorShortcuts.
	shortcuts do: [ :aNewEditorShortcut | self onShortcutAdded: aNewEditorShortcut ]
]

{ #category : #'text - styling' }
ToTextEditor >> styleText [
	"I request styler to re-style my current text"
	
	self styleTextAndAfterDo: [ :aStyledText | "do nothing" ]
]

{ #category : #'text - styling' }
ToTextEditor >> styleTextAndAfterDo: aBlock [
	"I first style, and then I do aBlock once I am finished"
	
	self dispatchEvent: (BrTextEditorTextStyleRequested new afterAction: aBlock)
]

{ #category : #accessing }
ToTextEditor >> styler [
	<return: #BlTextStyler>
	^ styler
]

{ #category : #accessing }
ToTextEditor >> styler: aStyler [
	styler = aStyler
		ifTrue: [ ^ self ].

	styler := aStyler.

	"styler changed, let's restyle the text"
	shouldStyleWhenTextModified
		ifTrue: [ self styleText ]
]

{ #category : #accessing }
ToTextEditor >> stylerStrategy [
	<return: #BrTextStylerStrategy>
	^ stylerStrategy
]

{ #category : #accessing }
ToTextEditor >> stylerStrategy: aBrTextStylerStrategy [
	self 
		assert: [ aBrTextStylerStrategy isNotNil ] 
		description: [ 'Text styler strategy must be non-nil' ].

	stylerStrategy := aBrTextStylerStrategy
]

{ #category : #'api - shortcuts' }
ToTextEditor >> surroundMap [
	"When inserting some special symbols a text editor should surround a cursor or selection with that symbol"

	| spaceBlock |
	spaceBlock := [ :anOperator :anIndex |
		(anOperator hasSpaceAroundIndex: anIndex)
			or: [ anOperator selection contains: anIndex ] ].

	^ BrTextEditorSurroundMap newFromArrays:
		{ 
			{ #'('. #')'. spaceBlock. }.
			{ #'"'. #'"'. spaceBlock. }.
			{ #''''. #''''. spaceBlock. }.
			{ #'['. #']'. spaceBlock. }.
			{ #'{'. #'}'. spaceBlock. }
		}
]

{ #category : #accessing }
ToTextEditor >> text [
	"Return a current text in the text editor. All modification to the text
	are reflected in the UI of the editor. For this reason I must only be
	used from a UI thread. To access a text from a non-UI thread use #textSnapshot
	which would give a copy of the current text"
	<return: #BlText>
	
	self assertUIProcess.
	^ text
]

{ #category : #accessing }
ToTextEditor >> text: aBrText [
	
	"when reducing the text size we should update the selection and cursor positions"
	(aBrText size < text size)
		ifTrue: [
			self navigator
				moveWithin: (0 to: aBrText size);
				apply.
			
			self deselecter
				from: aBrText size to: text size;
				deselect ].

	self restoreText: aBrText
]

{ #category : #accessing }
ToTextEditor >> textSnapshot [
	"Return a snaphost (copy) of the current text.
	I am safe to use from a non-UI thread because the returned text is independent from the
	current one and can be safely modified"
	<return: #BlText>

	^ text copy
]

{ #category : #asserting }
ToTextEditor >> uiProcesses [
	| theElementGroupedByProcess allUIProcesses |

	theElementGroupedByProcess := attachedElements groupedBy: [ :eachElement |
		| eachSpace eachUIProcess |
		eachSpace := eachElement isAttachedToSceneGraph
			ifTrue: [ eachElement space ]
			ifFalse: [ nil ].
		eachUIProcess := nil.
		eachSpace ifNotNil: [ eachSpace host uiProcessDo: [ :aProcess | eachUIProcess := aProcess ] ].
		eachUIProcess ].
	
	allUIProcesses := theElementGroupedByProcess keys reject: #isNil.

	^ allUIProcesses
]

{ #category : #'text - undo/redo' }
ToTextEditor >> undo [
	history undoOn: self
]

{ #category : #'private - updating' }
ToTextEditor >> updateSelection: aFromTextIndex to: aToTextIndex [
	"Update text rendering within an interval defined by provided from and to indices."
	| aCommand |
	
	aCommand := self newSelectionUpdateCommand
		fromIndex: aFromTextIndex;
		toIndex: aToTextIndex.
	self enqueueCommand: aCommand
]

{ #category : #'api - modification' }
ToTextEditor >> updater [
	<return: #BrTextEditorUpdater>

	^ BrTextEditorUpdater new editor: self
]

{ #category : #initialization }
ToTextEditor >> useAsyncStylerStrategy [
	self stylerStrategy: BrTextStylerAsyncStrategy new
]

{ #category : #initialization }
ToTextEditor >> useDefaultStylerStrategy [
	self stylerStrategy: self defaultStylerStrategy
]

{ #category : #initialization }
ToTextEditor >> useSyncStylerStrategy [
	self stylerStrategy: BrTextStylerSyncStrategy new
]

{ #category : #initialization }
ToTextEditor >> useTaskItStylerStrategy [
	self stylerStrategy: BrTextStylerTaskItStrategy new
]
