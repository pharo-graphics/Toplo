Class {
	#name : #ToActionRequiredFromCompagnonEvent,
	#superclass : #BlEvent,
	#instVars : [
		'valuable'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToActionRequiredFromCompagnonEvent >> valuable: aValuable [

	valuable := aValuable
]

{ #category : #accessing }
ToActionRequiredFromCompagnonEvent >> value: anObject [

	^ valuable value: anObject
]
