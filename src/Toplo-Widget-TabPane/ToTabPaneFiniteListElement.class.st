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

{ #category : #initialization }
ToTabPaneFiniteListElement >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeFactory: [ :holder | ToTabPaneNode new ];
		  yourself
]

{ #category : #skin }
ToTabPaneFiniteListElement >> newRawSkin [ 

	^ ToTabPaneFiniteListElementSkin new
]
