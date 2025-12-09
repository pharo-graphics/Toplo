Class {
	#name : #ToTabPaneFiniteListElement,
	#superclass : #ToTabFiniteListElement,
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #'t - finite list element - fake container' }
ToTabPaneFiniteListElement >> defaultFakeDataItem [

	^ ToTabButton new
		  labelText: 'X';
		  yourself
]

{ #category : #'t - item list - accessing' }
ToTabPaneFiniteListElement >> defaultNodeManagerClass [

	^ ToTabPaneNodeManager
]
