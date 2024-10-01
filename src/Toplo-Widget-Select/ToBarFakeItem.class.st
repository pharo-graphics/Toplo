Class {
	#name : #ToBarFakeItem,
	#superclass : #ToAbstractBarItem,
	#instVars : [
		'dataItem'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'instance creation' }
ToBarFakeItem class >> index: anIndex [

	^ self new index: anIndex; yourself
]

{ #category : #'node building' }
ToBarFakeItem >> buildNode: aNode inHolder: aNodeHolder withManager: aNodeManager [

	aNodeManager nodeBuilder value: aNode value: dataItem value: aNodeHolder
]

{ #category : #accessing }
ToBarFakeItem >> dataItem [

	^ dataItem 
]

{ #category : #accessing }
ToBarFakeItem >> dataItem: aDataItem [

	dataItem := aDataItem 
]

{ #category : #accessing }
ToBarFakeItem >> indexes [

	^ { }
]

{ #category : #accessing }
ToBarFakeItem >> items [

	^ { }
]

{ #category : #accessing }
ToBarFakeItem >> nodesCount [

	^ 0
]
