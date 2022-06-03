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

{ #category : #'api - hooks' }
ToLabelModel >> onInstalledIn: anElement [
	super onInstalledIn: anElement.
	self text: anElement defaultText.
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

	text := (aBlTextOrString ifNil: [ '' ]) asRopedText.
	self dispatchEvent: (ToLabelChanged new text: self text)
]
