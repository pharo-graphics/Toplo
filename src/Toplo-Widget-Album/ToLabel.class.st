Class {
	#name : #ToLabel,
	#superclass : #ToElement,
	#instVars : [
		'isEditable',
		'innerElement',
		'lineMode',
		'currText',
		'editorWindowManager'
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
	(self newEditorWindowEvent: anEvent) popupEvent: anEvent.
	
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

{ #category : #'api - text weight' }
ToLabel >> bold [

	self attributesBuilder attribute: BlFontWeightAttribute bold
]

{ #category : #'private-editing' }
ToLabel >> cleanUpUserData [

	self userData removeKey: #editor ifAbsent: [  ]
]

{ #category : #'private-editing' }
ToLabel >> currentEditorWindow [

	^ editorWindowManager currentWindow
]

{ #category : #initialization }
ToLabel >> defaultEventHandler [ 

	^ ToLabelEventHandler new
]

{ #category : #'api - text font' }
ToLabel >> defaultFontName: aString [

	self attributesBuilder attribute: (BlFontFamilyDefaultAttribute named: aString)
]

{ #category : #'api - text font' }
ToLabel >> defaultFontSize: aNumber [

	self attributesBuilder attribute: (BlFontSizeDefaultAttribute size: aNumber)
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

{ #category : #'api - text font' }
ToLabel >> fontName: aString [

	self attributesBuilder attribute: (BlFontFamilyAttribute named: aString)
]

{ #category : #'api - text font' }
ToLabel >> fontSize: aNumber [

	self attributesBuilder attribute: (BlFontSizeAttribute size: aNumber)
]

{ #category : #'api - text style' }
ToLabel >> foreground: aBlPaint [

	self attributesBuilder attribute: (BlTextForegroundAttribute paint: aBlPaint)
]

{ #category : #'private-editing' }
ToLabel >> hasEditor [

	^ editorWindowManager notNil and: [ editorWindowManager currentWindow notNil ]
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
ToLabel >> initializeEditorWindowBuilder [

	self isEditable
		ifTrue: [
			editorWindowManager := ToLabelEditorWindowManager new.
			self addEventHandler: editorWindowManager ]
		ifFalse: [
			editorWindowManager ifNil: [ ^ self ].
			self removeEventHandler: editorWindowManager.
			editorWindowManager := nil ]
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
	self initializeEditorWindowBuilder
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

{ #category : #'api - text emphasis' }
ToLabel >> italic [

	self attributesBuilder attribute: BlFontEmphasisAttribute italic
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
ToLabel >> newEditorWindowEvent: anEvent [

	^  editorWindowManager newWindowEvent: anEvent
]

{ #category : #skin }
ToLabel >> newRawSkin [ 

	^ ToLabelSkin new
]

{ #category : #accessing }
ToLabel >> newTextAttributesBuilder [
	
	^ ToLabelAttributesBuilder onLabel: self
]

{ #category : #'api - text emphasis' }
ToLabel >> normal [

	self attributesBuilder attribute: BlFontEmphasisAttribute normal
]

{ #category : #'api - text emphasis' }
ToLabel >> oblique [

	self attributesBuilder attribute: BlFontEmphasisAttribute oblique
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

{ #category : #'api - text weight' }
ToLabel >> regular [

	self attributesBuilder attribute: BlFontWeightAttribute normal
]

{ #category : #'private-editing' }
ToLabel >> removeEditor [

	editorWindowManager closeWindow.
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

{ #category : #'api - text style' }
ToLabel >> spacing: aNumber [

	self attributesBuilder attribute: (BlTextSpacingAttribute spacing: aNumber)
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

{ #category : #'api - text weight' }
ToLabel >> weight: aNumber [

	self attributesBuilder attribute: (BlFontWeightAttribute weight: aNumber)
]
