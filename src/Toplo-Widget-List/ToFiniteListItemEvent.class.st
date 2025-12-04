Class {
	#name : #ToFiniteListItemEvent,
	#superclass : #BlEvent,
	#instVars : [
		'item'
	],
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #accessing }
ToFiniteListItemEvent >> item [

	^ item
]

{ #category : #accessing }
ToFiniteListItemEvent >> item: anItem [

	item := anItem
]
