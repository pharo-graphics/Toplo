Class {
	#name : #ToSingleTag,
	#superclass : #ToAbstractTag,
	#instVars : [
		'data'
	],
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #'node building' }
ToSingleTag >> buildNode: aNode fromManager: aNodeManager [

	aNodeManager buildNode: aNode forSingleTagModel: self
]

{ #category : #accessing }
ToSingleTag >> data [

	^ data 
]

{ #category : #accessing }
ToSingleTag >> data: aData [

	data := aData
]

{ #category : #accessing }
ToSingleTag >> items [

	^ { self }
]

{ #category : #accessing }
ToSingleTag >> nodesCount [

	^ 1
]
