Class {
	#name : #ToLabelModel,
	#superclass : #OBlViewModel,
	#instVars : [
		'text'
	],
	#category : #'Toplo-Widgets'
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

{ #category : #'api - hooks' }
ToLabelModel >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self
		when: ToLabelChanged
		send: #whenTextChangedFromModel:
		to: anElement.
	self text: anElement defaultText
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

	text := (aBlTextOrString ifNil: [ self defaultText ]) asRopedText.
	self announce: (ToLabelChanged new text: self text)
]
