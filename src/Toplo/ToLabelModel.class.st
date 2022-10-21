Class {
	#name : #ToLabelModel,
	#superclass : #OBlViewModel,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#lineMode => ObservableSlot',
		'#text => ObservableSlot',
		'#editable => ObservableSlot',
		'#editorEventHandler'
	],
	#category : #'Toplo-Widget-Label'
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
ToLabelModel >> beEditableIn: anElement [

	editorEventHandler ifNotNil: [ ^ self ].
	editorEventHandler := BlEventHandler
		                      on: BlMouseDownEvent
		                      do: [ :anEvent | 
			                      (anEvent modifiers isShift and: [ anEvent modifiers isPrimaryModifier ]) ifTrue: [ 
				                      anElement addEditor ] ].
	anElement addEventHandler: editorEventHandler
]

{ #category : #editability }
ToLabelModel >> beReadOnlyIn: anElement [

	editorEventHandler ifNil: [ ^ self ].
	anElement removeEventHandler: editorEventHandler.
	editorEventHandler := nil
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

	editable := aBoolean
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
	lineMode := aLineMode
]

{ #category : #'api - hooks' }
ToLabelModel >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self whenTextChangedDo: [ :t | anElement privateText: t asRopedText ].
	self whenLineModeChangedDo: [ :lm | anElement privateLineModeChanged: lm ].
	self whenEditableChangedDo: [ :edi | 
		edi
			ifTrue: [ self beEditableIn: anElement ]
			ifFalse: [ self beReadOnlyIn: anElement ] ].
	self lineMode: self defaultLineMode.
	self text: self defaultText
]

{ #category : #'api - hooks' }
ToLabelModel >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: editorEventHandler.

]

{ #category : #accessing }
ToLabelModel >> text [
	<return: #BlText>

	^ text
]

{ #category : #accessing }
ToLabelModel >> text: aBlTextOrString [

	text = aBlTextOrString ifTrue: [ ^ self ].
	text := (aBlTextOrString ifNil: [ self defaultText ]) asRopedText
]

{ #category : #'api - change hook' }
ToLabelModel >> whenEditableChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #editable whenChangedDo: aBlock
]

{ #category : #'api - change hook' }
ToLabelModel >> whenLineModeChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #lineMode whenChangedDo: aBlock
]

{ #category : #'api - change hook' }
ToLabelModel >> whenTextChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #text whenChangedDo: aBlock
]
