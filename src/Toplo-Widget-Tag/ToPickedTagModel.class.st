Class {
	#name : #ToPickedTagModel,
	#superclass : #ToSingleTagModel,
	#instVars : [
		'pickOrder'
	],
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #accessing }
ToPickedTagModel >> pickOrder [

	^ pickOrder
]

{ #category : #accessing }
ToPickedTagModel >> pickOrder: anInteger [

	pickOrder := anInteger
]
