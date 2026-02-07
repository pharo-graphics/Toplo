Class {
	#name : #ToDeselectedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#instVars : [
		'focused',
		'selectionOption'
	],
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToDeselectedSkinEvent >> focused [

	^ focused
]

{ #category : #accessing }
ToDeselectedSkinEvent >> focused: aBoolean [

	focused := aBoolean
]

{ #category : #accessing }
ToDeselectedSkinEvent >> selectionMode [

	^ self selectionOption selectionMode
]

{ #category : #accessing }
ToDeselectedSkinEvent >> selectionOption [

	^ selectionOption
]

{ #category : #accessing }
ToDeselectedSkinEvent >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption
]

{ #category : #sending }
ToDeselectedSkinEvent >> sendTo: anObject [

	anObject deselectedSkinEvent: self
]
