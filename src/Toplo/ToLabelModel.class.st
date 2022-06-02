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
ToLabelModel >> initialize [
	super initialize.
	
	text := 'Label' asRopedText
]

{ #category : #notifying }
ToLabelModel >> notifyLabelChanged [
	self dispatchEvent: (ToLabelChanged new text: self text)
]

{ #category : #initialization }
ToLabelModel >> onInstalledIn: anElement [
	super onInstalledIn: anElement.
	self when: ToLabelRequest reply: [ :aResponse | aResponse text: self text ].
	self notifyLabelChanged 
]

{ #category : #accessing }
ToLabelModel >> text [
	<return: #BlText>

	^ text
]

{ #category : #accessing }
ToLabelModel >> text: aBlTextOrString [
	<event: #BrLabelChanged>

	text = aBlTextOrString
		ifTrue: [ ^ self ].

	text := aBlTextOrString asRopedText.

	self notifyLabelChanged
]
