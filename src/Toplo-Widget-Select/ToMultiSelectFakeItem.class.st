Class {
	#name : #ToMultiSelectFakeItem,
	#superclass : #ToAbstractMultiSelectItem,
	#instVars : [
		'dataItem'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'instance creation' }
ToMultiSelectFakeItem class >> index: anIndex [

	^ self new index: anIndex; yourself
]

{ #category : #'node building' }
ToMultiSelectFakeItem >> buildNode: aNode inHolder: aNodeHolder withManager: aNodeManager [

	aNodeManager nodeBuilder value: aNode value: dataItem value: aNodeHolder
]

{ #category : #accessing }
ToMultiSelectFakeItem >> dataItem [

	^ dataItem 
]

{ #category : #accessing }
ToMultiSelectFakeItem >> dataItem: aDataItem [

	dataItem := aDataItem 
]

{ #category : #accessing }
ToMultiSelectFakeItem >> indexes [

	^ { }
]

{ #category : #accessing }
ToMultiSelectFakeItem >> items [

	^ { }
]

{ #category : #accessing }
ToMultiSelectFakeItem >> nodesCount [

	^ 0
]
