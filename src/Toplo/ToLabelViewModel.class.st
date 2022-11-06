Class {
	#name : #ToLabelViewModel,
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
ToLabelViewModel class >> modelName [
	^ 'Label'
]

{ #category : #'instance creation' }
ToLabelViewModel class >> text: aStringOrText [
	^ self new text: aStringOrText
]

{ #category : #editability }
ToLabelViewModel >> beEditable [

	self editable: true
]

{ #category : #initialization }
ToLabelViewModel >> beMonoLine [

	self widgetPerformOrDefer: [:widget | self lineMode: ToLabelMonoLineMode new ]
]

{ #category : #initialization }
ToLabelViewModel >> beMultiLine [

	self widgetPerformOrDefer: [:widget | self lineMode: ToLabelMultiLineMode new ]
]

{ #category : #editability }
ToLabelViewModel >> beReadOnly [ 

	self editable: false
]

{ #category : #initialization }
ToLabelViewModel >> defaultLineMode [

	^ ToLabelMonoLineMode new
]

{ #category : #initialization }
ToLabelViewModel >> defaultText [

	^ '' asRopedText
]

{ #category : #accessing }
ToLabelViewModel >> editable [

	^ editable
]

{ #category : #accessing }
ToLabelViewModel >> editable: aBoolean [

	editable = aBoolean ifTrue: [ ^ self ].
	self widgetPerformOrDefer: [:label | editable := aBoolean ]
]

{ #category : #initialization }
ToLabelViewModel >> initialize [
	
	self class initializeSlots: self.
	editable := false.
	super initialize.
	

]

{ #category : #accessing }
ToLabelViewModel >> lineMode [

	^ lineMode
]

{ #category : #accessing }
ToLabelViewModel >> lineMode: aLineMode [

	lineMode = aLineMode ifTrue: [ ^ self ].
	self widgetPerformOrDefer: [ :label | lineMode := aLineMode ]
]

{ #category : #'api - hooks' }
ToLabelViewModel >> onInstalledOnlyMeIn: anElement [

	super onInstalledOnlyMeIn: anElement.
	self text: self defaultText.
	self onTextReplacedDo: [ :t | anElement privateText: t asRopedText ].
	self whenLineModeChangedDo: [ :lm | anElement privateLineModeChanged: lm ].
	self whenEditableChangedDo: [ :edi | 
		edi
			ifTrue: [ self privateBeEditableIn: anElement ]
			ifFalse: [ self privateBeReadOnlyIn: anElement ] ].
	self lineMode: self defaultLineMode


]

{ #category : #'api - change hook' }
ToLabelViewModel >> onTextReplacedDo: aBlock [

	"Inform when text property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #text whenChangedDo: aBlock
]

{ #category : #'api - hooks' }
ToLabelViewModel >> onUninstalledOnlyMeIn: anElement [

	super onUninstalledOnlyMeIn: anElement.
	editorEventHandler ifNotNil: [ anElement removeEventHandler: editorEventHandler ]
]

{ #category : #'private editability' }
ToLabelViewModel >> privateBeEditableIn: anElement [

	editorEventHandler ifNotNil: [ ^ self ].
	editorEventHandler := BlEventHandler
		                      on: BlMouseDownEvent
		                      do: [ :anEvent | 
			                      (anEvent modifiers isShift and: [ anEvent modifiers isPrimaryModifier ]) ifTrue: [ 
				                      anElement addEditor ] ].
	anElement addEventHandler: editorEventHandler
]

{ #category : #'private editability' }
ToLabelViewModel >> privateBeReadOnlyIn: anElement [

	editorEventHandler ifNil: [ ^ self ].
	anElement removeEventHandler: editorEventHandler.
	editorEventHandler := nil
]

{ #category : #'private - accessing - widget' }
ToLabelViewModel >> privateNewWidget [

	^ ToLabel new
]

{ #category : #accessing }
ToLabelViewModel >> text [
	<return: #BlText>

	^ text
]

{ #category : #accessing }
ToLabelViewModel >> text: aBlTextOrString [

	text = aBlTextOrString ifTrue: [ ^ self ].
	self widgetPerformOrDefer: [ :label | text := (aBlTextOrString ifNil: [ self defaultText ]) asRopedText ]
]

{ #category : #'api - change hook' }
ToLabelViewModel >> whenEditableChangedDo: aBlock [

	"Inform when editable property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #editable whenChangedDo: aBlock
]

{ #category : #'api - change hook' }
ToLabelViewModel >> whenLineModeChangedDo: aBlock [

	"Inform when lineMode property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #lineMode whenChangedDo: aBlock
]
