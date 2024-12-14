Class {
	#name : #ToPickedTag,
	#superclass : #ToSingleTag,
	#instVars : [
		'pickOrder'
	],
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #accessing }
ToPickedTag >> pickOrder [

	^ pickOrder
]

{ #category : #accessing }
ToPickedTag >> pickOrder: anInteger [

	pickOrder := anInteger
]
