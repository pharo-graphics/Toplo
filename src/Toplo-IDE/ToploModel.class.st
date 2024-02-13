Class {
	#name : #ToploModel,
	#superclass : #Object,
	#category : #'Toplo-IDE-theme-serialization'
}

{ #category : #converting }
ToploModel >> asSourceCodeOn: aStream [

	
]

{ #category : #accessing }
ToploModel >> comment [

	^ '"This method has been generated.<r><r><t>By: <1s><r><t><2s> <3s>"'
		  expandMacrosWith: Author uniqueInstance fullName
		  with: Date today yyyymmdd
		  with: Time now print24
]

{ #category : #accessing }
ToploModel >> selector [

	^ self shouldBeImplemented
]
