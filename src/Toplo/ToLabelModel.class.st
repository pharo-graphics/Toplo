Class {
	#name : #ToLabelModel,
	#superclass : #OBlViewModel,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#lineMode => ObservableSlot',
		'#text => ObservableSlot'
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

{ #category : #initialization }
ToLabelModel >> defaultLineMode [

	^ ToLabelMonoLineMode new
]

{ #category : #initialization }
ToLabelModel >> defaultText [

	^ ''
]

{ #category : #initialization }
ToLabelModel >> initialize [
	
	self class initializeSlots: self.
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
	self whenLineModeChangedDo: [ :lm | anElement privateLineMode: lm ].
	self lineMode: self defaultLineMode.
	self text: self defaultText.
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
ToLabelModel >> whenLineModeChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #lineMode whenChangedDo: aBlock
]

{ #category : #'api - change hook' }
ToLabelModel >> whenTextChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #text whenChangedDo: aBlock
]
