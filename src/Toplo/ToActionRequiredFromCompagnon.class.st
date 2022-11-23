Class {
	#name : #ToActionRequiredFromCompagnon,
	#superclass : #Announcement,
	#instVars : [
		'valuable'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToActionRequiredFromCompagnon >> valuable: aValuable [

	valuable := aValuable
]

{ #category : #accessing }
ToActionRequiredFromCompagnon >> value: anObject [

	^ valuable value: anObject
]
