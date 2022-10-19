Class {
	#name : #ToLabelModel,
	#superclass : #OBlViewModel,
	#classTraits : 'TObservable classTrait',
	#instVars : [
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
ToLabelModel >> defaultText [

	^ ''
]

{ #category : #initialization }
ToLabelModel >> initialize [
	
	self class initializeSlots: self.
	super initialize.
]

{ #category : #'api - hooks' }
ToLabelModel >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self whenTextChangedDo: [ :t | anElement textElement text: t asRopedText ].
	self text: self defaultText
]

{ #category : #accessing }
ToLabelModel >> text [
	<return: #BlText>

	^ text
]

{ #category : #accessing }
ToLabelModel >> text: aBlTextOrString [

	<event: #BrLabelChanged>
	text = aBlTextOrString ifTrue: [ ^ self ].
	text := (aBlTextOrString ifNil: [ self defaultText ]) asRopedText
]

{ #category : #enumerating }
ToLabelModel >> whenTextChangedDo: aBlock [
	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #text whenChangedDo: aBlock
]
