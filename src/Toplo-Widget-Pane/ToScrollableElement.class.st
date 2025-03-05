Class {
	#name : #ToScrollableElement,
	#superclass : #BlScrollableElement,
	#traits : 'TToElement + TBlLayoutResizable',
	#classTraits : 'TToElement classTrait + TBlLayoutResizable classTrait',
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #initialization }
ToScrollableElement >> defaultEventHandler [

	^ ToScrollableElementEventHandler new
]

{ #category : #layout }
ToScrollableElement >> layoutFixGap: aLayoutNode [

	self flag: 'One have to investigate the usefulness of this method in the superclass'.
	" do nothing here, else the scrollable element layouting can behave strangly when removing a node (the layout turn in a strange scrolling mode until the top or the left is reached )"
]
