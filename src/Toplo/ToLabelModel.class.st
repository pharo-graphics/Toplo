Class {
	#name : #ToLabelModel,
	#superclass : #ToViewModel,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#lineMode => ObservableSlot',
		'#text => ObservableSlot',
		'#editable => ObservableSlot',
		'#editorEventHandler'
	],
	#category : #'Toplo-Widget-Labels'
}

{ #category : #printing }
ToLabelModel class >> modelName [
	^ 'Label'
]

{ #category : #'instance creation' }
ToLabelModel class >> text: aStringOrText [
	^ self new text: aStringOrText
]

{ #category : #editability }
ToLabelModel >> beEditable [

	self editable: true
]

{ #category : #initialization }
ToLabelModel >> beMonoLine [

	self widgetDo: [:widget | self lineMode: ToLabelMonoLineMode new ]
]

{ #category : #initialization }
ToLabelModel >> beMultiLine [

	self widgetDo: [:widget | self lineMode: ToLabelMultiLineMode new ]
]

{ #category : #editability }
ToLabelModel >> beReadOnly [ 

	self editable: false
]

{ #category : #initialization }
ToLabelModel >> defaultLineMode [

	^ ToLabelMonoLineMode new
]

{ #category : #initialization }
ToLabelModel >> defaultText [

	^ '' asRopedText
]

{ #category : #accessing }
ToLabelModel >> editable [

	^ editable
]

{ #category : #accessing }
ToLabelModel >> editable: aBoolean [

	editable = aBoolean ifTrue: [ ^ self ].
	self widgetDo: [:label | editable := aBoolean ]
]

{ #category : #initialization }
ToLabelModel >> initialize [
	
	self class initializeSlots: self.
	editable := false.
	super initialize.
	

]

{ #category : #accessing }
ToLabelModel >> lineMode [

	^ lineMode
]

{ #category : #accessing }
ToLabelModel >> lineMode: aLineMode [

	lineMode = aLineMode ifTrue: [ ^ self ].
	self widgetDo: [ :label | lineMode := aLineMode ]
]

{ #category : #'api - hooks' }
ToLabelModel >> onInstalledOnlyMeIn: anElement [

	super onInstalledOnlyMeIn: anElement.
	self text: self defaultText.
	self whenTextReplacedDo: [ :t | anElement privateText: t asRopedText ].
	self whenLineModeChangedDo: [ :lm | anElement privateLineModeChanged: lm ].
	self whenEditableChangedDo: [ :edi | 
		edi
			ifTrue: [ self privateBeEditableIn: anElement ]
			ifFalse: [ self privateBeReadOnlyIn: anElement ] ].
	self lineMode: self defaultLineMode


]

{ #category : #'api - hooks' }
ToLabelModel >> onUninstalledOnlyMeIn: anElement [

	super onUninstalledOnlyMeIn: anElement.
	editorEventHandler ifNotNil: [ anElement removeEventHandler: editorEventHandler ]
]

{ #category : #'private editability' }
ToLabelModel >> privateBeEditableIn: anElement [

	editorEventHandler ifNotNil: [ ^ self ].
	editorEventHandler := BlEventHandler
		                      on: BlMouseDownEvent
		                      do: [ :anEvent | 
			                      (anEvent modifiers isShift and: [ anEvent modifiers isPrimaryModifier ]) ifTrue: [ 
				                      anElement addEditor ] ].
	anElement addEventHandler: editorEventHandler
]

{ #category : #'private editability' }
ToLabelModel >> privateBeReadOnlyIn: anElement [

	editorEventHandler ifNil: [ ^ self ].
	anElement removeEventHandler: editorEventHandler.
	editorEventHandler := nil
]

{ #category : #'private - accessing - widget' }
ToLabelModel >> privateWidgetClass [

	^ ToLabel
]

{ #category : #accessing }
ToLabelModel >> text [
	<return: #BlText>

	^ text
]

{ #category : #accessing }
ToLabelModel >> text: aBlTextOrString [

	text = aBlTextOrString ifTrue: [ ^ self ].
	self widgetDo: [ :label | text := (aBlTextOrString ifNil: [ self defaultText ]) asRopedText ]
]

{ #category : #'api - change hook' }
ToLabelModel >> whenEditableChangedDo: aBlock [

	"Inform when editable property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #editable whenChangedDo: aBlock
]

{ #category : #'api - change hook' }
ToLabelModel >> whenLineModeChangedDo: aBlock [

	"Inform when lineMode property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #lineMode whenChangedDo: aBlock
]

{ #category : #'api - change hook' }
ToLabelModel >> whenTextReplacedDo: aBlock [

	"Inform when text property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #text whenChangedDo: aBlock
]
