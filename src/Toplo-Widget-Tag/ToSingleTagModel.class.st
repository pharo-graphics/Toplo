Class {
	#name : #ToSingleTagModel,
	#superclass : #ToAbstractTagModel,
	#instVars : [
		'data'
	],
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #'node building' }
ToSingleTagModel >> buildNode: aNode inHolder: aNodeHolder withManager: aNodeManager [

	aNodeManager nodeBuilder value: aNode value: data value: aNodeHolder.
	aNode addEventHandlerOn: ToTagRemovedEvent do: [ :event |
		event consume.
		event currentTarget removeFromBar ]
]

{ #category : #accessing }
ToSingleTagModel >> data [

	^ data 
]

{ #category : #accessing }
ToSingleTagModel >> data: aData [

	data := aData
]

{ #category : #accessing }
ToSingleTagModel >> items [

	^ { self }
]

{ #category : #accessing }
ToSingleTagModel >> nodesCount [

	^ 1
]
