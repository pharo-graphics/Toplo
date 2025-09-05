Class {
	#name : #ToSkinManagementState,
	#superclass : #ToSimpleState,
	#classInstVars : [
		'instance'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #accessing }
ToSkinManagementState class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
ToSkinManagementState >> skinEvent [ 

	^ self skinEventClass new
]

{ #category : #accessing }
ToSkinManagementState >> skinEventClass [ 

	^ self subclassResponsibility 
]
