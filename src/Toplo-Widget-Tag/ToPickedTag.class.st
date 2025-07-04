Class {
	#name : #ToPickedTag,
	#superclass : #ToSingleTag,
	#instVars : [
		'pickOrder'
	],
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #accessing }
ToPickedTag >> pickOrder [

	^ pickOrder
]

{ #category : #accessing }
ToPickedTag >> pickOrder: anInteger [

	pickOrder := anInteger
]
