Class {
	#name : #ToSingleTagModel,
	#superclass : #ToAbstractTagModel,
	#instVars : [
		'data'
	],
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #'node building' }
ToSingleTagModel >> buildNode: aNode fromManager: aNodeManager [

	aNodeManager buildNode: aNode forSingleTagModel: self
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
