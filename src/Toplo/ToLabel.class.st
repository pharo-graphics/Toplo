Class {
	#name : #ToLabel,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip + TToWidgetWithViewModel + TToEditable + TBlAlignable',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithViewModel classTrait + TToEditable classTrait + TBlAlignable classTrait',
	#instVars : [
		'#innerElement',
		'#text => ObservableSlot',
		'#lineMode => ObservableSlot'
	],
	#category : #'Toplo-Widget-Label'
}

{ #category : #'instance creation' }
ToLabel class >> text: aText [

	^ self new text: aText
]

{ #category : #'private-editing' }
ToLabel >> addEditor [

	self isEditable ifFalse: [ ^ self ].
	self addEditor: self newEditor
]

{ #category : #'private-editing' }
ToLabel >> addEditor: anEditor [

	self editor ifNotNil: [ ^ self ].
	self editor: anEditor.
	self dispatchEvent: ToLabelEditorAddedEvent new.
	self editor text: self text copy.
	self editorFrame: (self newEditorFrameForEditor: self editor).
	self innerElement visibility: BlVisibility hidden.
	self editorFrame popup.
	self editor when: ToLabelEditorRemoveRequestEvent do: [ self removeEditor ].
	self editor requestFocus.
	self editor selecter
		all;
		apply
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
	self userData removeKey: #editor
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

{ #category : #'private-editing' }
ToLabel >> editor [

	^ self userData at: #editor ifAbsent: [  ]
]

{ #category : #'private-editing' }
ToLabel >> editor: anEditor [

	self userData at: #editor put: anEditor
]

{ #category : #'private-editing' }
ToLabel >> editorFrame [

	^ self userData at: #editorFrame ifAbsent: [  ]
]

{ #category : #'private-editing' }
ToLabel >> editorFrame: anAnchoredWindow [

	self userData at: #editorFrame put: anAnchoredWindow
]

{ #category : #'private-editing' }
ToLabel >> hasEditor [

	^ self editor notNil
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
	self initializeEditable.
	self layout: self defaultLayout.
	self constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal fitContent ].
	
	" need to initialize the dresser before setting lineMode and text"
	self initializeDresser.
	
	self lineMode: self defaultLineMode.
	self text: self defaultText.

]

{ #category : #accessing }
ToLabel >> innerElement [

	^ innerElement
]

{ #category : #accessing }
ToLabel >> innerElement: anInnerElement [

	innerElement := anInnerElement 
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

{ #category : #'private-editing' }
ToLabel >> newEditorFrameForEditor: anEditor [

	^ ToAnchoredWindow new
		  popupAnimationFactory: nil;
		  anchor: self innerElement;
		  in: [ :aw | aw root addChild: anEditor ];
		  yourself
]

{ #category : #'private-change' }
ToLabel >> privateText: aText [

	self innerElement text: aText
]

{ #category : #'private-editing' }
ToLabel >> removeEditor [

	self editor ifNil: [ ^ self ].
	self editorFrame removeFromParent.
	self innerElement visibility: BlVisibility visible.
	self cleanUpUserData.
	self dispatchEvent: ToLabelEditorRemovedEvent new.

]

{ #category : #layout }
ToLabel >> requestLayout [

	self innerElement ifNotNil: [:ie | ie requestLayout ].
	super requestLayout
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

{ #category : #accessing }
ToLabel >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self layout verticalAlignment
]

{ #category : #accessing }
ToLabel >> verticalAlignment: aBlElementAlignment [

	self layout verticalAlignment: aBlElementAlignment
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
