Class {
	#name : #ToSelectedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#instVars : [
		'focused',
		'selectionOption'
	],
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToSelectedSkinEvent >> focused [

	^ focused
]

{ #category : #accessing }
ToSelectedSkinEvent >> focused: aBoolean [

	focused := aBoolean
]

{ #category : #'instance creation' }
ToSelectedSkinEvent >> fromState: aState [

	super fromState: aState.
	self focused: aState focused.
	self selectionOption: aState selectionOption
]

{ #category : #accessing }
ToSelectedSkinEvent >> selectionOption [

	^ selectionOption
]

{ #category : #accessing }
ToSelectedSkinEvent >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption
]

{ #category : #sending }
ToSelectedSkinEvent >> sendTo: anObject [

	anObject selectedSkinEvent: self
]
