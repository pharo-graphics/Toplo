Class {
	#name : #ToPickedTagModel,
	#superclass : #ToSingleTagModel,
	#instVars : [
		'pickOrder'
	],
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #'node building' }
ToPickedTagModel >> buildNode: aNode inHolder: aNodeHolder withManager: aNodeManager [

	super buildNode: aNode inHolder: aNodeHolder withManager: aNodeManager.
	aNode addEventHandlerOn: ToInnerElementRemovedEvent do: [ :event |
		event consume.
		aNode removeFromBar ]
]

{ #category : #accessing }
ToPickedTagModel >> pickOrder [

	^ pickOrder
]

{ #category : #accessing }
ToPickedTagModel >> pickOrder: anInteger [

	pickOrder := anInteger
]
