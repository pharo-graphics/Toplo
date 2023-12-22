Class {
	#name : 'ToListNodeHolderEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'holder'
	],
	#category : 'Toplo-Widget-List-Node',
	#package : 'Toplo-Widget-List',
	#tag : 'Node'
}

{ #category : 'accessing' }
ToListNodeHolderEvent >> holder [

	^ holder
]

{ #category : 'accessing' }
ToListNodeHolderEvent >> holder: anHolder [

	holder := anHolder
]
