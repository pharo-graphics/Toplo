Class {
	#name : #ToLabel,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip + TToWidgetWithViewModel + TToEditable + TBlAlignable',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithViewModel classTrait + TToEditable classTrait + TBlAlignable classTrait',
	#instVars : [
		'#textReplacedHandler',
		'#innerElement',
		'#text => ObservableSlot',
		'#lineMode => ObservableSlot',
		'#editorEventHandler'
	],
	#category : #'Toplo-Widget-Label'
}

{ #category : #'instance creation' }
ToLabel class >> text: aText [

	^ self new text: aText
]

{ #category : #'private-editing' }
ToLabel >> addEditor [

	self addEditor: self newEditor
]

{ #category : #'private-editing' }
ToLabel >> addEditor: anEditor [

	self editor ifNotNil: [^ self ].	
	self editor: anEditor.
	self editor text: self text copy.
	self editorFrame: (ToAnchoredWindow new popupAnimationFactory: nil).
	self editorFrame anchor: self innerElement.
	self editorFrame root addChild: anEditor.
	self editorFrame geometry: self editor geometry.
	self innerElement visibility: BlVisibility hidden.
	self editorFrame popup.
	self editorFocusHandler: (BlEventHandler on: BlFocusEvent do: [ self editorFrame toFront ]).
	self editor infinite addEventHandler: self editorFocusHandler.
	self editor effect:
		(BlGaussianShadowEffect
			 color: Color gray
			 width: 10
			 offset: 0 asPoint).
	self editor requestFocus.
	self editor selecter all; apply
	
]

{ #category : #initialization }
ToLabel >> beMonoLine [

	self lineMode: ToLabelMultiLineMode new
]

{ #category : #initialization }
ToLabel >> beMultiLine [

	self lineMode: ToLabelMultiLineMode new
]

{ #category : #'private-editing' }
ToLabel >> cleanUpUserData [

	self userData removeKey: #editorFrame.
	self userData removeKey: #editor.
	self editorFocusHandler: nil.

]

{ #category : #initialization }
ToLabel >> defaultDresser [

	^ ToLabelDresser new
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

{ #category : #'private-change' }
ToLabel >> editabilityChanged [

	self isEditable
		ifTrue: [ self privateBeEditable ]
		ifFalse: [ self privateBeReadOnly ]
]

{ #category : #'private-editing' }
ToLabel >> editor [

	^ self userData at: #editor ifAbsent: [  ]
]

{ #category : #'private-editing' }
ToLabel >> editor: anEditor [

	self userData at: #editor put: anEditor
]

{ #category : #'private-editing' }
ToLabel >> editorFocusHandler [

	^ self userData at: #editorFocusHandler 
]

{ #category : #'private-editing' }
ToLabel >> editorFocusHandler: anHandler [

	anHandler ifNil: [ ^ self userData removeKey: #editorFocusHandler ].
	self userData at: #editorFocusHandler put: anHandler
]

{ #category : #'private-editing' }
ToLabel >> editorFrame [

	^ self userData at: #editorFrame ifAbsent: [  ]
]

{ #category : #'private-editing' }
ToLabel >> editorFrame: anAnchoredWindow [

	self userData at: #editorFrame put: anAnchoredWindow
]

{ #category : #accessing }
ToLabel >> hasText [

	^ self text notNil and: [ self text isNotEmpty ]
]

{ #category : #initialization }
ToLabel >> initialize [

	self class initializeSlots: self.
	super initialize.
	self initializeEditable.
	self constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal fitContent ].
	self whenTextReplacedDo: [ self privateText: self text ].
	self whenLineModeChangedDo: [ self privateLineModeChanged ].
	self lineMode: self defaultLineMode.
	self text: self defaultText.
	self whenEditableChangedDo: [ self editabilityChanged ].
	
	self initializeDresser

]

{ #category : #accessing }
ToLabel >> innerElement [

	^ innerElement
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
	lineMode := aLineMode
]

{ #category : #initialization }
ToLabel >> monoLine: aBoolean [

	aBoolean
		ifTrue: [ self beMonoLine ]
		ifFalse: [ self beMultiLine ]
]

{ #category : #'private-editing' }
ToLabel >> newEditor [

	^ self innerElement newEditorIn: self
]

{ #category : #'private-change' }
ToLabel >> privateBeEditable [
 
	editorEventHandler ifNotNil: [ ^ self ].
	editorEventHandler := BlEventHandler
		                      on: BlMouseDownEvent
		                      do: [ :anEvent | 
			                      (anEvent modifiers isShift and: [ 
				                       anEvent modifiers isPrimaryModifier ]) 
				                      ifTrue: [ 
					                      anEvent consumed: true.
					                      self addEditor ] ].
	self addEventHandler: editorEventHandler
]

{ #category : #'private-change' }
ToLabel >> privateBeReadOnly [

	editorEventHandler ifNil: [ ^ self ].
	self removeEventHandler: editorEventHandler.
	editorEventHandler := nil 
]

{ #category : #'private-change' }
ToLabel >> privateLineModeChanged [
	| currText |
	currText := self text.
	self removeChildren.
	self privateReplaceTextElement.
	currText ifNotNil: [innerElement text: currText].
	self layout: self defaultLayout.
	self addChild: innerElement
]

{ #category : #'private-change' }
ToLabel >> privateLineModeChanged: aLineMode [
	| currText |
	currText := self text.
	self removeChildren.
	self privateReplaceTextElement.
	currText ifNotNil: [innerElement text: currText].
	self layout: self defaultLayout.
	self addChild: innerElement
]

{ #category : #'private-change' }
ToLabel >> privateReplaceTextElement [

	innerElement ifNotNil: [ 
		innerElement removeEventHandler: textReplacedHandler ].
	innerElement := self defaultTextElement.
	textReplacedHandler := BlEventHandler
		                       on: ToTextReplacedEvent
		                       do: [ :evt | self text: evt text ].
	innerElement addEventHandler: textReplacedHandler
]

{ #category : #'private-change' }
ToLabel >> privateText: aText [

	self innerElement text: aText
]

{ #category : #'private-editing' }
ToLabel >> removeEditor [

	self editor ifNil: [ ^ self ].
	self editorFrame close.
	self editor infinite removeEventHandler: self editorFocusHandler.
	self innerElement visibility: BlVisibility visible.
	self requestLayout.
	self cleanUpUserData
]

{ #category : #accessing }
ToLabel >> text [
	<return: #BlText>

	^ text
]

{ #category : #accessing }
ToLabel >> text: aBlTextOrString [

	text = aBlTextOrString ifTrue: [ ^ self ].
	text := (aBlTextOrString ifNil: [ self defaultText ]) asRopedText
]

{ #category : #'change hook' }
ToLabel >> whenLineModeChangedDo: aBlock [

	"Inform when lineMode property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #lineMode whenChangedDo: aBlock
]

{ #category : #'change hook' }
ToLabel >> whenTextReplacedDo: aBlock [

	"Inform when text property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #text whenChangedDo: aBlock
]
