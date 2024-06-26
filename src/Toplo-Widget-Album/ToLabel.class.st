Class {
	#name : #ToLabel,
	#superclass : #ToElement,
	#traits : 'TBlAlignable',
	#classTraits : 'TBlAlignable classTrait',
	#instVars : [
		'isEditable',
		'innerElement',
		'lineMode',
		'frameManager'
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
	self editor requestFocus.
	self editor selecter
		all;
		apply.
	self editorBuilder value: self editor value: self
]

{ #category : #'text decoration applying' }
ToLabel >> applyAttributesBuilder [

	self attributesBuilder applyOn: self text
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

	self restoreTextAfter: [ self lineMode: ToLabelMonoLineMode new ]
]

{ #category : #initialization }
ToLabel >> beMultiLine [

	self restoreTextAfter: [ self lineMode: ToLabelMultiLineMode new ]
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

	^ ToLabelMonoLineMode new
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

{ #category : #accessing }
ToLabel >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment
]

{ #category : #accessing }
ToLabel >> horizontalAlignment: aBlElementAlignment [

	self layout horizontalAlignment: aBlElementAlignment
]

{ #category : #initialization }
ToLabel >> initialize [

	self class initializeSlots: self.
	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	
	self layout: self defaultLayout.
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
			frameManager onInstalledIn: self ]
		ifFalse: [
			frameManager ifNil: [ ^ self ].
			frameManager element: nil.
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

{ #category : #'private-change' }
ToLabel >> privateText: aText [

	self innerElement text: aText
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

{ #category : #accessing }
ToLabel >> text [
	<return: #BlText>

	^ self innerElement text
]

{ #category : #accessing }
ToLabel >> text: aBlTextOrString [

	| newText |
	self text = aBlTextOrString ifTrue: [ ^ self ].
	newText := (aBlTextOrString ifNil: [ self defaultText ]) asRopedText.
	self privateText: newText.
	self dispatchEvent: (ToLabelTextReplacedEvent new text: self text)
]

{ #category : #'event handling' }
ToLabel >> textChanged [

	self innerElement textChanged.
	self requestNewSkin
]

{ #category : #accessing }
ToLabel >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self layout verticalAlignment
]

{ #category : #accessing }
ToLabel >> verticalAlignment: aBlElementAlignment [

	self layout verticalAlignment: aBlElementAlignment
]
