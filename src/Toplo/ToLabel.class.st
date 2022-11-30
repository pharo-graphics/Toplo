Class {
	#name : #ToLabel,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip + TToWidgetWithViewModel',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithViewModel classTrait',
	#instVars : [
		'#textReplacedHandler',
		'#innerElement',
		'#text => ObservableSlot',
		'#editable => ObservableSlot',
		'#lineMode => ObservableSlot',
		'#editorEventHandler'
	],
	#category : #'Toplo-Widget-Label'
}

{ #category : #'private-editing' }
ToLabel >> addEditor [

	| editor |
	editor := self innerElement newEditorIn: self.
	self addEditor: editor
]

{ #category : #'private-editing' }
ToLabel >> addEditor: anEditor [

	| editorOverlay |
	self userData at: #editorOverlay ifPresent: [ ^ self ].
	self userData at: #editorOverlay put: (editorOverlay := BlOverlayElement new).
	self userData at: #editor put: anEditor.
	anEditor innerElement margin: self innerElement margin.
	editorOverlay clipChildren: false.
	self previousElevation: self elevation.
	self elevation: (BlRelativeElevation elevation: 1000).
	editorOverlay attachTo: self innerElement.
	editorOverlay addChild: anEditor.
	anEditor border: BlBorder empty.
	self previousClipping: self clipChildren.
	self previousVisibility: self innerElement visibility.
	self previousTextElementClipping: self innerElement clipChildren.
	self innerElement visibility: BlVisibility hidden.
	self innerElement clipChildren: false.
	self clipChildren: false.
	self addChild: editorOverlay.
	anEditor text: self text copy.
	anEditor innerElement requestFocus.
	anEditor innerElement selecter all; apply
	
]

{ #category : #initialization }
ToLabel >> beEditable [

	self editable: true
]

{ #category : #initialization }
ToLabel >> beMonoLine [

	self lineMode: ToLabelMultiLineMode new
]

{ #category : #initialization }
ToLabel >> beMultiLine [

	self lineMode: ToLabelMultiLineMode new
]

{ #category : #initialization }
ToLabel >> beReadOnly [

	self editable: false
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

{ #category : #accessing }
ToLabel >> editable [

	^ editable
]

{ #category : #accessing }
ToLabel >> editable: aBoolean [

	editable = aBoolean ifTrue: [ ^ self ].
	editable := aBoolean.
	aBoolean
		ifTrue: [ self privateBeEditable ]
		ifFalse: [ self privateBeReadOnly ]
]

{ #category : #'private-editing' }
ToLabel >> editor [

	^ self userData at: #editor
]

{ #category : #'private-editing' }
ToLabel >> editorOverlay [

	^ self userData at: #editorOverlay 
]

{ #category : #initialization }
ToLabel >> initialize [

	self class initializeSlots: self.
	super initialize.
	editable := false.
	self constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal fitContent ].
	self whenTextReplacedDo: [ self privateText: self text ].
	self whenLineModeChangedDo: [ self privateLineModeChanged ].
	self lineMode: self defaultLineMode.
	self text: self defaultText.
	self dresser: self defaultDresser

]

{ #category : #accessing }
ToLabel >> innerElement [

	^ innerElement
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

{ #category : #'private-editing' }
ToLabel >> newEditor [

	^ self innerElement newEditor
]

{ #category : #'private-editing' }
ToLabel >> previousClipping [
	^ self userData at: #previousClipping 
]

{ #category : #'private-editing' }
ToLabel >> previousClipping: aBoolean [
	self userData at: #previousClipping put: aBoolean
]

{ #category : #'private-editing' }
ToLabel >> previousElevation [

	^ self userData at: #previousElevation
]

{ #category : #'private-editing' }
ToLabel >> previousElevation: aBlElevation [

	self userData at: #previousElevation put: aBlElevation
]

{ #category : #'private-editing' }
ToLabel >> previousTextElementClipping [
	^ self userData at: #previousTextElementClipping 
]

{ #category : #'private-editing' }
ToLabel >> previousTextElementClipping: aBoolean [
	self userData at: #previousTextElementClipping put: aBoolean
]

{ #category : #'private-editing' }
ToLabel >> previousVisibility [

	^ self userData at: #previousVisibility
]

{ #category : #'private-editing' }
ToLabel >> previousVisibility: aBlVisibility [

	self userData at: #previousVisibility put: aBlVisibility
]

{ #category : #'private-change' }
ToLabel >> privateBeEditable [

	editorEventHandler ifNotNil: [ ^ self ].
	editorEventHandler := BlEventHandler
		                      on: BlMouseDownEvent
		                      do: [ :anEvent | 
			                      (anEvent modifiers isShift and: [ anEvent modifiers isPrimaryModifier ]) ifTrue: [ 
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

	| editorOverlay |
	self userData at: #editor ifAbsent: [ ^ self ].
	editorOverlay := self editorOverlay.
	editorOverlay detach.
	editorOverlay removeChildren.
	self removeChild: editorOverlay.
	self elevation: self previousElevation.
	self clipChildren: self previousClipping.
	self innerElement clipChildren: self previousTextElementClipping.
	self innerElement visibility: self previousVisibility.
	self userData removeKey: #previousElevation.
	self userData removeKey: #editorOverlay.
	self userData removeKey: #editor.
	self userData removeKey: #previousClipping.
	self userData removeKey: #previousTextElementClipping.

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

{ #category : #'api - change hook' }
ToLabel >> whenEditableChangedDo: aBlock [

	"Inform when editable property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #editable whenChangedDo: aBlock
]

{ #category : #'api - change hook' }
ToLabel >> whenLineModeChangedDo: aBlock [

	"Inform when lineMode property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #lineMode whenChangedDo: aBlock
]

{ #category : #'api - change hook' }
ToLabel >> whenTextReplacedDo: aBlock [

	"Inform when text property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #text whenChangedDo: aBlock
]
