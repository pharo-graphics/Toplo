"
I'm used as a data item of list. 
My parent list old refers to the element that contains the list that contains me.

"
Class {
	#name : #ToItemElement,
	#superclass : #ToElement,
	#traits : 'TToItem',
	#classTraits : 'TToItem classTrait',
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #initialization }
ToItemElement >> defaultLayout [

	^ BlLinearLayout vertical
]
