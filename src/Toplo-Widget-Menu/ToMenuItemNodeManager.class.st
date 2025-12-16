Class {
	#name : #ToMenuItemNodeManager,
	#superclass : #ToItemFiniteListNodeManager,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #initialization }
ToMenuItemNodeManager >> defaultNodeFactory [ 

	^ [ :holder | ToMenuItemNode new ]
]
