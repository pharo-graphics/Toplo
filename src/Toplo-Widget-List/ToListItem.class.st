"
I'm used as a data item of list. 
My parent list old refers to the element that contains the list that contains me.

"
Class {
	#name : #ToListItem,
	#superclass : #ToElement,
	#traits : 'TToItem',
	#classTraits : 'TToItem classTrait',
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #initialization }
ToListItem >> defaultLayout [

	^ BlLinearLayout vertical
]
