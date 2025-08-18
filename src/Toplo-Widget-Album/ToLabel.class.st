Class {
	#name : #ToLabel,
	#superclass : #ToShrinkableContainer,
	#traits : 'TToElementWithContentEditor',
	#classTraits : 'TToElementWithContentEditor classTrait',
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

{ #category : #converting }
ToLabel >> asToLabelText [ 

	^ self text copy
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

{ #category : #'t - element with content editor' }
ToLabel >> beforeEditorClosed: anEditorElement fromManager: aManager [
	" sent from the window manager "

	innerElement visibility: BlVisibility visible
]

{ #category : #'t - element with content editor' }
ToLabel >> beforeEditorOpened: anEditorElement fromManager: aManager [
	" sent from the window manager "

	innerElement visibility: BlVisibility hidden
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

{ #category : #accessing }
ToLabel >> editorWindowManager [

	^ editorWindowManager 
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

	super initialize.
	self class initializeSlots: self.
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
	" the first position ensure that the inner element will be used to shrink myself because
	only the first element is taken into account.
	see ToShrinkableContainer>>onChildAdded: "
	self addChild: innerElement at: 1
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
			self addEventHandler: ToLabelEditorManager new ]
		ifFalse: [
			editorWindowManager ifNil: [ ^ self ].
			self removeEventHandler: editorWindowManager ]
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

{ #category : #'t - element with content editor' }
ToLabel >> newEditorForManager: aManager [

	^ aManager newEditorForLabel: self
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

{ #category : #'t - element with content editor' }
ToLabel >> onInstalledEditorManager: anEditorManager [

	editorWindowManager := anEditorManager
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

{ #category : #'t - element with content editor' }
ToLabel >> onUninstalledEditorManager: anEditorManager [

	editorWindowManager := nil
]

{ #category : #'private-editing' }
ToLabel >> popupEditorEvent: anEvent [
	" prepare the window with the editor and open it"

	self hasEditor ifTrue: [ ^ self ].
	(editorWindowManager newWindowEvent: anEvent) ifNotNil: [ :win |
		win popupEvent: anEvent ]
]

{ #category : #printing }
ToLabel >> printOn: aStream [

	aStream << self class name << '(' << self text asString << ')'
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
	" subscribe to internal text state change (insertion/deletion/attribute change) "
	newText := (aBlTextOrString ifNil: [ self defaultText ]) asRopedText.
	self privateText: newText.
	self requestNewSkin
]

{ #category : #'private-change' }
ToLabel >> textChanged [

	self innerElement textChanged
]

{ #category : #'api - text weight' }
ToLabel >> thin [

	self attributesBuilder attribute: BlFontWeightAttribute thin
]

{ #category : #'api - text weight' }
ToLabel >> weight: aNumber [

	self attributesBuilder attribute: (BlFontWeightAttribute weight: aNumber)
]

{ #category : #'private-editing' }
ToLabel >> whenEditorClosedDo: aValuable [

	editorWindowManager whenEditorClosedDo: aValuable
]

{ #category : #'private-editing' }
ToLabel >> whenEditorOpenedDo: aValuable [

	editorWindowManager whenEditorOpenedDo: aValuable
]
