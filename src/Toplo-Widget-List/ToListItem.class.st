"
I'm used as a data item of list. 
My parent list old refers to the element that contains the list that contains me.

"
Class {
	#name : #ToListItem,
	#superclass : #ToElement,
	#traits : 'TToListItem',
	#classTraits : 'TToListItem classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToListItem >> applyConfiguration [ 

	super applyConfiguration.
	self applyConfigurationAsListItem
]

{ #category : #initialization }
ToListItem >> defaultLayout [

	^ BlLinearLayout vertical
]
