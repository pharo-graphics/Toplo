Class {
	#name : #ToInstallSkinRequest,
	#superclass : #ToSkinManagementEvent,
	#instVars : [
		'accepted'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #accessing }
ToInstallSkinRequest >> accepted [

	^ accepted ifNil: [ accepted := true ]
]

{ #category : #accessing }
ToInstallSkinRequest >> accepted: aBoolean [

	accepted := aBoolean
]

{ #category : #sending }
ToInstallSkinRequest >> sendTo: anObject [

	anObject installSkinRequest: self
]
