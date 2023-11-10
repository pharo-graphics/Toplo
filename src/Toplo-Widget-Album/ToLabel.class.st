Class {
	#name : 'ToLabel',
	#superclass : 'ToElement',
	#traits : 'TBlAlignable + TObservable',
	#classTraits : 'TBlAlignable classTrait + TObservable classTrait',
	#instVars : [
		'#isEditable',
		'#innerElement',
		'#text => ObservableSlot',
		'#lineMode',
		'#frameHandler'
	],
	#category : 'Toplo-Widget-Album-Label',
	#package : 'Toplo-Widget-Album',
	#tag : 'Label'
}

{ #category : 'instance creation' }
ToLabel class >> text: aText [

	^ self new text: aText
]

{ #category : 'private-editing' }
ToLabel >> addEditorEvent: anEvent [

	self innerElement visibility: BlVisibility hidden.
	self hasEditor ifTrue: [  ^ self ].
	(self newEditorFrameEvent: anEvent) popupEvent: anEvent.
	self editor requestFocus.
	self editor selecter
		all;
		apply
	
]

{ #category : 'accessing' }
ToLabel >> beEditable [

	self isEditable: true
]

{ #category : 'initialization' }
ToLabel >> beMonoLine [

	self lineMode: ToLabelMultiLineMode new
]

{ #category : 'initialization' }
ToLabel >> beMultiLine [

	self lineMode: ToLabelMultiLineMode new
]

{ #category : 'accessing' }
ToLabel >> beReadOnly [

	self isEditable: false
]

{ #category : 'private-editing' }
ToLabel >> cleanUpUserData [

	self userData removeKey: #editor
]

{ #category : 'private-editing' }
ToLabel >> currentEditorFrame [

	^ frameHandler currentWindow
]

{ #category : 'initialization' }
ToLabel >> defaultEventHandler [ 

	^ ToLabelEventHandler new
]

{ #category : 'initialization' }
ToLabel >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : 'initialization' }
ToLabel >> defaultLineMode [

	^ ToLabelMonoLineMode new
]

{ #category : 'initialization' }
ToLabel >> defaultPadding [

	^ BlInsets empty
		  
]

{ #category : 'initialization' }
ToLabel >> defaultText [

	^ '' asRopedText
]

{ #category : 'initialization' }
ToLabel >> defaultTextElement [

	^ self lineMode newTextElementIn: self
]

{ #category : 'private-editing' }
ToLabel >> editor [

	^ self userData at: #editor ifAbsent: [  ]
]

{ #category : 'api - text style' }
ToLabel >> foreground: aBlPaint [

	self text foreground: aBlPaint.
	self requestLayout 
]

{ #category : 'private-editing' }
ToLabel >> hasEditor [

	^ frameHandler notNil and: [ frameHandler currentWindow notNil ]
]

{ #category : 'accessing' }
ToLabel >> hasText [

	^ self text notNil and: [ self text isNotEmpty ]
]

{ #category : 'accessing' }
ToLabel >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment
]

{ #category : 'accessing' }
ToLabel >> horizontalAlignment: aBlElementAlignment [

	self layout horizontalAlignment: aBlElementAlignment
]

{ #category : 'initialization' }
ToLabel >> initialize [

	self class initializeSlots: self.
	super initialize.
	
	self layout: self defaultLayout.
	self fitContent.

	self text: self defaultText.
	self lineMode: self defaultLineMode.
	self innerElement: self defaultTextElement.	

	self isEditable: false.
	self addEventHandler: self defaultEventHandler 
]

{ #category : 'initialization' }
ToLabel >> initializeEditorFrameBuilder [

	self isEditable
		ifTrue: [
			frameHandler := ToAnchoredWindowHandler new.
			frameHandler positionHook: [ :event :theLabel |
				theLabel innerElement bounds inSpace bounds topLeft
				- (theLabel editor padding left
					 @ theLabel editor padding top) ].
			frameHandler element: self.
			frameHandler builder: [ :anchWin :label |
				anchWin root addChild: self newEditor.
				self editor text: self text copy ] ]
		ifFalse: [
			frameHandler ifNil: [ ^ self ].
			frameHandler element: nil.
			frameHandler := nil ]
]

{ #category : 'accessing' }
ToLabel >> innerElement [

	^ innerElement
]

{ #category : 'accessing' }
ToLabel >> innerElement: anInnerElement [

	| handler |
	innerElement = anInnerElement ifTrue: [ ^ self ].
	innerElement ifNotNil: [ innerElement removeFromParent ].
	innerElement := anInnerElement.
	
	handler := (BlEventHandler on: ToTextReplacedEvent do: [ :evt | self text: evt text ]).
	innerElement addEventHandler: handler.
	
	self addChild: innerElement
]

{ #category : 'accessing' }
ToLabel >> isEditable [

	^ isEditable 
]

{ #category : 'accessing' }
ToLabel >> isEditable: aBoolean [

	isEditable = aBoolean ifTrue: [ ^ self ].
	isEditable := aBoolean.
	self initializeEditorFrameBuilder
]

{ #category : 'accessing' }
ToLabel >> isMonoLine [

	^ self lineMode
		  ifNil: [ ^ false ]
		  ifNotNil: [ :mode | mode isMonoLine ]
]

{ #category : 'accessing' }
ToLabel >> isMultiLine [

	^ self lineMode
		  ifNil: [ ^ false ]
		  ifNotNil: [ :mode | mode isMultiLine ]
]

{ #category : 'accessing' }
ToLabel >> lineMode [

	^ lineMode
]

{ #category : 'accessing' }
ToLabel >> lineMode: aLineMode [

	lineMode = aLineMode ifTrue: [ ^ self ].
	lineMode := aLineMode.
	self lineModeChanged 
]

{ #category : 'private-change' }
ToLabel >> lineModeChanged [

	self innerElement: self defaultTextElement.	
	self innerElement text: self text
]

{ #category : 'initialization' }
ToLabel >> monoLine: aBoolean [

	aBoolean
		ifTrue: [ self beMonoLine ]
		ifFalse: [ self beMultiLine ]
]

{ #category : 'private-editing' }
ToLabel >> newEditor [

	^ self userData at: #editor put: (self innerElement newEditorIn: self)
]

{ #category : 'private-editing' }
ToLabel >> newEditorFrameEvent: anEvent [

	^  frameHandler newWindowEvent: anEvent
]

{ #category : 'private-change' }
ToLabel >> privateText: aText [

	text := aText.
	self innerElement ifNotNil: [:inner | inner text: aText ]
]

{ #category : 'private-editing' }
ToLabel >> removeEditor [

	self currentEditorFrame close.
	self innerElement visibility: BlVisibility visible.
	self cleanUpUserData

]

{ #category : 'accessing' }
ToLabel >> text [
	<return: #BlText>

	^ text
]

{ #category : 'accessing' }
ToLabel >> text: aBlTextOrString [

	| newText |
	text = aBlTextOrString ifTrue: [ ^ self ].
	newText := (aBlTextOrString ifNil: [ self defaultText ]) asRopedText.
	self privateText: newText
]

{ #category : 'event handling' }
ToLabel >> textChanged [

	self innerElement textChanged.
	self forceLocalLayout
]

{ #category : 'accessing' }
ToLabel >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self layout verticalAlignment
]

{ #category : 'accessing' }
ToLabel >> verticalAlignment: aBlElementAlignment [

	self layout verticalAlignment: aBlElementAlignment
]

{ #category : 'change hook' }
ToLabel >> whenTextReplacedDo: aBlock [

	"Inform when text property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #text whenChangedDo: aBlock
]
