Class {
	#name : #ToTabPaneNodeManager,
	#superclass : #ToTabNodeManager,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #initialization }
ToTabPaneNodeManager >> defaultFakeDataItem [

	^ ToTabButton new
		  labelText: 'X';
		  yourself
]

{ #category : #'instance creation' }
ToTabPaneNodeManager >> newHolder [ 

	^ ToTabPaneNodeHolder new
]
