"
I'm used as a data item of list. 
My parent list old refers to the element that contains the list that contains me.

"
Class {
	#name : #ToBarItemElement,
	#superclass : #ToElement,
	#traits : 'TToItem',
	#classTraits : 'TToItem classTrait',
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #initialization }
ToBarItemElement >> defaultLayout [

	^ BlLinearLayout vertical
]
