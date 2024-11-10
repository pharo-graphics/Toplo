Class {
	#name : #ToLabel,
	#superclass : #ToElement,
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'isEditable',
		'innerElement',
		'lineMode',
		'frameManager',
		'currText'
	],
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'instance creation' }
ToLabel class >> text: aText [

	^ self new text: aText
]

{ #category : #'private-editing' }
ToLabel >> addEditorEvent: anEvent [

	self innerElement visibility: BlVisibility hidden.
	self hasEditor ifTrue: [  ^ self ].
	(self newEditorFrameEvent: anEvent) popupEvent: anEvent.
	
	self editor selecter
		all;
		apply.
	self editorBuilder value: self editor value: self.
	self editor requestFocus
]

{ #category : #styling }
ToLabel >> applyAttributesBuilder [

	self
		deprecated: 'Use #applyStyle instead'
		transformWith: '`@recvr applyAttributesBuilder' -> '`@recvr applyStyle'.
	self applyStyle
]

{ #category : #styling }
ToLabel >> applyStyle [

	self text ifNil: [ ^ self ].
	self attributesBuilder applyOn: self text
]

{ #category : #accessing }
ToLabel >> attributes: anArray [

	self attributesBuilder attributes: anArray
]

{ #category : #accessing }
ToLabel >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ self textAttributesBuilder
]

{ #category : #accessing }
ToLabel >> beEditable [

	self isEditable: true
]

{ #category : #initialization }
ToLabel >> beMonoLine [

	self restoreTextAfter: [ self lineMode: ToLabelLineMode mono ]
]

{ #category : #initialization }
ToLabel >> beMultiLine [

	self restoreTextAfter: [ self lineMode: ToLabelLineMode multi ]
]

{ #category : #accessing }
ToLabel >> beReadOnly [

	self isEditable: false
]

{ #category : #'private-editing' }
ToLabel >> cleanUpUserData [

	self userData removeKey: #editor ifAbsent: [  ]
]

{ #category : #'private-editing' }
ToLabel >> currentEditorFrame [

	^ frameManager currentWindow
]

{ #category : #initialization }
ToLabel >> defaultEventHandler [ 

	^ ToLabelEventHandler new
]

{ #category : #initialization }
ToLabel >> defaultLineMode [

	^ ToLabelLineMode mono
]

{ #category : #initialization }
ToLabel >> defaultPadding [

	^ BlInsets empty
		  
]

{ #category : #initialization }
ToLabel >> defaultText [

	^ '' asRopedText
]

{ #category : #initialization }
ToLabel >> defaultTextElement [

	^ self lineMode newTextElementIn: self
]

{ #category : #'private-editing' }
ToLabel >> editor [

	^ self userData at: #editor ifAbsent: [  ]
]

{ #category : #accessing }
ToLabel >> editorBuilder [
	" returns a valuable that takes the editor and the label as arguments "

	^ self userData at: #editorBuilder ifAbsentPut: [ [ :ed :theLabel | ] ]
]

{ #category : #accessing }
ToLabel >> editorBuilder: aValuable [
	" aValuable takes the editor and the label as arguments "

	self userData at: #editorBuilder put: aValuable
]

{ #category : #'private-editing' }
ToLabel >> hasEditor [

	^ frameManager notNil and: [ frameManager currentWindow notNil ]
]

{ #category : #accessing }
ToLabel >> hasText [

	^ self text notNil and: [ self text isNotEmpty ]
]

{ #category : #initialization }
ToLabel >> initialize [

	self class initializeSlots: self.
	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	self fitContent.

	self lineMode: self defaultLineMode.
	self innerElement: self defaultTextElement.	
	self text: self defaultText.

	self isEditable: false.
	self addEventHandler: self defaultEventHandler 
]

{ #category : #'private-editing' }
ToLabel >> initializeEditorFrameBuilder [

	self isEditable
		ifTrue: [
			frameManager := ToLabelEditorWindowManager new.
			self addEventHandler: frameManager ]
		ifFalse: [
			frameManager ifNil: [ ^ self ].
			self removeEventHandler: frameManager.
			frameManager := nil ]
]

{ #category : #accessing }
ToLabel >> innerElement [

	^ innerElement
]

{ #category : #accessing }
ToLabel >> innerElement: anInnerElement [

	innerElement = anInnerElement ifTrue: [ ^ self ].
	innerElement ifNotNil: [ innerElement removeFromParent ].
	innerElement := anInnerElement.
	self addChild: innerElement
]

{ #category : #accessing }
ToLabel >> isEditable [

	^ isEditable 
]

{ #category : #accessing }
ToLabel >> isEditable: aBoolean [

	isEditable = aBoolean ifTrue: [ ^ self ].
	isEditable := aBoolean.
	self initializeEditorFrameBuilder
]

{ #category : #testing }
ToLabel >> isFrozen [

	^ false
]

{ #category : #accessing }
ToLabel >> isMonoLine [

	^ self lineMode
		  ifNil: [ ^ false ]
		  ifNotNil: [ :mode | mode isMonoLine ]
]

{ #category : #accessing }
ToLabel >> isMultiLine [

	^ self lineMode
		  ifNil: [ ^ false ]
		  ifNotNil: [ :mode | mode isMultiLine ]
]

{ #category : #accessing }
ToLabel >> lineMode [

	^ lineMode
]

{ #category : #accessing }
ToLabel >> lineMode: aLineMode [

	lineMode = aLineMode ifTrue: [ ^ self ].
	lineMode := aLineMode.
	self lineModeChanged 
]

{ #category : #'private-change' }
ToLabel >> lineModeChanged [

	self restoreTextAfter: [ self innerElement: self defaultTextElement ]
]

{ #category : #initialization }
ToLabel >> monoLine: aBoolean [

	aBoolean
		ifTrue: [ self beMonoLine ]
		ifFalse: [ self beMultiLine ]
]

{ #category : #'private-editing' }
ToLabel >> newEditor [

	^ self userData at: #editor put: (self innerElement newEditorIn: self)
]

{ #category : #'private-editing' }
ToLabel >> newEditorFrameEvent: anEvent [

	^  frameManager newWindowEvent: anEvent
]

{ #category : #skin }
ToLabel >> newRawSkin [ 

	^ ToLabelSkin new
]

{ #category : #accessing }
ToLabel >> newTextAttributesBuilder [
	
	^ ToLabelAttributesBuilder onLabel: self
]

{ #category : #'private-change' }
ToLabel >> onStringsInserted: aBlTextStringsInserted [

	self isFrozen ifTrue: [ ^ self ].
	aBlTextStringsInserted strings ifEmpty: [ ^ self ].
	currText := self text copy.
	self textChanged
]

{ #category : #'private-change' }
ToLabel >> onTextAttributeAdded: aBlTextAttributeAdded [
	
	self isFrozen ifTrue: [ ^ self ].
	currText rope = self text rope ifTrue: [ ^ self ].
	currText := self text copy.
	self textChanged

]

{ #category : #'private-change' }
ToLabel >> onTextAttributesRemoved: aBlTextAttributesRemoved [

	self isFrozen ifTrue: [ ^ self ].
	currText rope = self text rope ifTrue: [ ^ self ].
	currText := self text copy.
	self textChanged

]

{ #category : #'private-change' }
ToLabel >> onTextsDeleted: aString [

	self isFrozen ifTrue: [ ^ self ].
	aString ifEmpty: [  ^ self ].
	currText := self text copy.
	self textChanged
]

{ #category : #'private-change' }
ToLabel >> privateText: aText [

	self innerElement text: aText.
	currText:= self text copy.
	self text
		when: BlTextStringsInserted
		send: #onStringsInserted:
		to: self.
	self text when: BlTextsDeleted send: #onTextsDeleted: to: self.
	self text
		when: BlTextAttributeAdded
		send: #onTextAttributeAdded:
		to: self.
	self text
		when: BlTextAttributesRemoved
		send: #onTextAttributesRemoved:
		to: self
]

{ #category : #'private-editing' }
ToLabel >> removeEditor [

	self currentEditorFrame ifNotNil: [:w | w close].
	self innerElement visibility: BlVisibility visible.
	self cleanUpUserData
]

{ #category : #'private-change' }
ToLabel >> restoreTextAfter: aBlock [

	| t |
	t := self innerElement ifNotNil: [ :inner | inner text ].
	aBlock value.
	t ifNil: [ ^ self ].
	self text: t
]

{ #category : #rotation }
ToLabel >> rotateBy: aDegreesAngle [

	self innerElement
		constraintsDo: [ :c | c accountTransformation ];
		transformDo: [ :t | t rotateBy: aDegreesAngle ]
]

{ #category : #styling }
ToLabel >> style [


	self
		deprecated: 'Use #applyStyle instead'
		transformWith: '`@recvr style' -> '`@recvr applyStyle'.

	self applyStyle
]

{ #category : #accessing }
ToLabel >> text [
	<return: #BlText>

	^ self innerElement text
]

{ #category : #accessing }
ToLabel >> text: aBlTextOrString [

	| newText |
	self isFrozen ifTrue: [ ^ self ].
	self text = aBlTextOrString ifTrue: [ ^ self ].
	" unsubscribe previous text "
	self text ifNotNil: [self text unsubscribe: self].
	" subscribe to internal text state change (insertion/deletion/attribute change) "
	newText := (aBlTextOrString ifNil: [ self defaultText ]) asRopedText.
	self privateText: newText.
	self dispatchEvent: (ToLabelTextReplacedEvent new text: self text).
	self requestNewSkin
]

{ #category : #'private-change' }
ToLabel >> textChanged [

	self innerElement textChanged
]
