Class {
	#name : #ToLabelViewModel,
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
ToLabelViewModel class >> modelName [
	^ 'Label'
]

{ #category : #'instance creation' }
ToLabelViewModel class >> text: aStringOrText [
	^ self new text: aStringOrText
]

{ #category : #editability }
ToLabelViewModel >> beEditableIn: anElement [

	editorEventHandler ifNotNil: [ ^ self ].
	editorEventHandler := BlEventHandler
		                      on: BlMouseDownEvent
		                      do: [ :anEvent | 
			                      (anEvent modifiers isShift and: [ anEvent modifiers isPrimaryModifier ]) ifTrue: [ 
				                      anElement addEditor ] ].
	anElement addEventHandler: editorEventHandler
]

{ #category : #editability }
ToLabelViewModel >> beReadOnlyIn: anElement [

	editorEventHandler ifNil: [ ^ self ].
	anElement removeEventHandler: editorEventHandler.
	editorEventHandler := nil
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

	editable := aBoolean
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
	lineMode := aLineMode
]

{ #category : #'api - hooks' }
ToLabelViewModel >> onInstalledIn: anElement [

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
ToLabelViewModel >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: editorEventHandler.

]

{ #category : #accessing }
ToLabelViewModel >> text [
	<return: #BlText>

	^ text
]

{ #category : #accessing }
ToLabelViewModel >> text: aBlTextOrString [

	text = aBlTextOrString ifTrue: [ ^ self ].
	text := (aBlTextOrString ifNil: [ self defaultText ]) asRopedText
]

{ #category : #'api - change hook' }
ToLabelViewModel >> whenEditableChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #editable whenChangedDo: aBlock
]

{ #category : #'api - change hook' }
ToLabelViewModel >> whenLineModeChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #lineMode whenChangedDo: aBlock
]

{ #category : #'api - change hook' }
ToLabelViewModel >> whenTextChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #text whenChangedDo: aBlock
]
