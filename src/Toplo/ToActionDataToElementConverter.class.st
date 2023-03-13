Class {
	#name : #ToActionDataToElementConverter,
	#superclass : #ToDataToElementConverter,
	#instVars : [
		'valuable'
	],
	#category : #'Toplo-Core'
}

{ #category : #evaluating }
ToActionDataToElementConverter >> cull: aData cull: anObject [

	^ self valuable cull: aData cull: anObject
]

{ #category : #accessing }
ToActionDataToElementConverter >> valuable [

	^ valuable
]

{ #category : #accessing }
ToActionDataToElementConverter >> valuable: aValuable [

	valuable := aValuable
]
