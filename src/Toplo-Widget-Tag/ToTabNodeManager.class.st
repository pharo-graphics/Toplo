Class {
	#name : #ToTabNodeManager,
	#superclass : #ToCheckableBarNodeManager,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #initialization }
ToTabNodeManager >> defaultFakeDataItem [

	^ ToTabItemElement new
		  labelText: 'X';
		  yourself
]

{ #category : #'instance creation' }
ToTabNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToTabNode new
]
