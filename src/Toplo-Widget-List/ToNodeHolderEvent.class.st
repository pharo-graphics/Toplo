Class {
	#name : 'ToNodeHolderEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'holder'
	],
	#category : 'Toplo-Widget-List-node',
	#package : 'Toplo-Widget-List',
	#tag : 'node'
}

{ #category : 'accessing' }
ToNodeHolderEvent >> holder [

	^ holder
]

{ #category : 'accessing' }
ToNodeHolderEvent >> holder: anHolder [

	holder := anHolder
]
