Class {
	#name : #ToTabNodeManager,
	#superclass : #ToCheckableBarNodeManager,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #initialization }
ToTabNodeManager >> defaultFakeDataItem [

	^ ToItemToggleButton new
		  middleElement: (ToLabel text: 'X');
		  yourself
]

{ #category : #'instance creation' }
ToTabNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToTabNode new
]
