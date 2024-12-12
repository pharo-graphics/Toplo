Class {
	#name : #ToLabel,
	#superclass : #ToElement,
	#instVars : [
		'innerElement',
		'editorWindowManager',
		'currentText'
	],
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'instance creation' }
ToLabel class >> text: aText [

	^ self new text: aText
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

{ #category : #configurating }
ToLabel >> beEditable [

	self isEditable: true
]

{ #category : #configurating }
ToLabel >> beMonoLine [

	self multiLine: false
]

{ #category : #configurating }
ToLabel >> beMultiLine [

	self multiLine: true
]

{ #category : #configurating }
ToLabel >> beReadOnly [

	self isEditable: false
]

{ #category : #'api - text weight' }
ToLabel >> bold [

	self attributesBuilder attribute: BlFontWeightAttribute bold
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
ToLabel >> defaultPadding [

	^ BlInsets empty
		  
]

{ #category : #initialization }
ToLabel >> defaultText [

	^ '' asRopedText
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
	" my window manager has a window "

	^ editorWindowManager notNil and: [
		  editorWindowManager currentWindow notNil ]
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
	self focusability: BlFocusability none.

	self initializeInnerElement.
	self text: self defaultText.

	self isEditable: false.
	self addEventHandler: self defaultEventHandler 
]

{ #category : #initialization }
ToLabel >> initializeInnerElement [

	self innerElement: ToLabelMonoLineInnerElement new
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

{ #category : #testing }
ToLabel >> isEditable [

	^ editorWindowManager notNil 
]

{ #category : #accessing }
ToLabel >> isEditable: aBoolean [

	aBoolean
		ifTrue: [
			editorWindowManager ifNotNil: [ ^ self ].
			editorWindowManager := ToLabelEditorWindowManager new.
			self addEventHandler: editorWindowManager ]
		ifFalse: [
			editorWindowManager ifNil: [ ^ self ].
			self removeEventHandler: editorWindowManager.
			editorWindowManager := nil ]
]

{ #category : #testing }
ToLabel >> isFrozen [

	^ false
]

{ #category : #testing }
ToLabel >> isMonoLine [

	^ innerElement isMonoLine 
]

{ #category : #testing }
ToLabel >> isMultiLine [

	^ innerElement isMonoLine not
]

{ #category : #'api - text emphasis' }
ToLabel >> italic [

	self attributesBuilder attribute: BlFontEmphasisAttribute italic
]

{ #category : #accessing }
ToLabel >> monoLine: aBoolean [

	self multiLine: aBoolean not
]

{ #category : #accessing }
ToLabel >> multiLine: aBoolean [

	| inner |
	aBoolean
		ifTrue: [
			self isMultiLine ifTrue: [ ^ self ].
			inner := ToLabelMultiLineInnerElement new ]
		ifFalse: [
			self isMonoLine ifTrue: [ ^ self ].
			inner := ToLabelMonoLineInnerElement new ].
	self restoreTextAfter: [ self innerElement: inner ]
]

{ #category : #'private-editing' }
ToLabel >> newEditor [
	" sent from the window manager "

	^ innerElement newEditor
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

{ #category : #'private-editing' }
ToLabel >> onEditorClosed [
	" sent from the window manager "

	innerElement visibility: BlVisibility visible
]

{ #category : #'private-editing' }
ToLabel >> onEditorOpened [
	" sent from the window manager "

	innerElement visibility: BlVisibility hidden
]

{ #category : #'private-change' }
ToLabel >> onStringsInserted: aBlTextStringsInserted [

	self isFrozen ifTrue: [ ^ self ].
	aBlTextStringsInserted strings ifEmpty: [ ^ self ].
	currentText := self text copy.
	self textChanged
]

{ #category : #'private-change' }
ToLabel >> onTextAttributeAdded: aBlTextAttributeAdded [
	
	self isFrozen ifTrue: [ ^ self ].
	currentText rope = self text rope ifTrue: [ ^ self ].
	currentText := self text copy.
	self textChanged

]

{ #category : #'private-change' }
ToLabel >> onTextAttributesRemoved: aBlTextAttributesRemoved [

	self isFrozen ifTrue: [ ^ self ].
	currentText rope = self text rope ifTrue: [ ^ self ].
	currentText := self text copy.
	self textChanged

]

{ #category : #'private-change' }
ToLabel >> onTextsDeleted: aBlTextsDeleted [

	self isFrozen ifTrue: [ ^ self ].
	currentText := self text copy.
	self textChanged
]

{ #category : #'private-editing' }
ToLabel >> popupEditorEvent: anEvent [
	" prepare the window with the editor and open it"

	self hasEditor ifTrue: [ ^ self ].
	(editorWindowManager newWindowEvent: anEvent) ifNotNil: [ :win |
		win popupEvent: anEvent ]
]

{ #category : #'private-change' }
ToLabel >> privateText: aText [

	self innerElement text: aText.
	currentText:= self text copy.
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
