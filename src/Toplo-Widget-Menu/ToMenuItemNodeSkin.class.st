Class {
	#name : #ToMenuItemNodeSkin,
	#superclass : #ToItemNodeSkin,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #'event handling' }
ToMenuItemNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'menu-node-padding-H')
				 vertical: (e valueOfTokenNamed: #'menu-node-padding-V')) ]
]
