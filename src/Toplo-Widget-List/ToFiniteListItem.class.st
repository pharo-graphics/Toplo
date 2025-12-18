"
I'm used as a data item of list. 
My parent list old refers to the element that contains the list that contains me.

"
Class {
	#name : #ToFiniteListItem,
	#superclass : #ToElement,
	#traits : 'TToItem',
	#classTraits : 'TToItem classTrait',
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #configuration }
ToFiniteListItem >> applyConfiguration [ 

	super applyConfiguration.
]

{ #category : #initialization }
ToFiniteListItem >> defaultLayout [

	^ BlLinearLayout vertical
]
