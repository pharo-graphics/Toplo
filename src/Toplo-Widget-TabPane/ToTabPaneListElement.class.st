Class {
	#name : #ToTabPaneListElement,
	#superclass : #ToTabListElement,
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #accessing }
ToTabPaneListElement >> defaultFakeDataItem [

	^ ToTabButton new
		  labelText: 'X';
		  yourself
]

{ #category : #initialization }
ToTabPaneListElement >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeFactory: [ :holder | ToTabPaneNode new ];
		  yourself
]

{ #category : #skin }
ToTabPaneListElement >> newRawSkin [ 

	^ ToTabPaneListElementSkin new
]
