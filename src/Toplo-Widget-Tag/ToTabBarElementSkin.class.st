Class {
	#name : #ToTabBarElementSkin,
	#superclass : #ToItemBarElementSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabBarElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| selTrack |
		e background: Color transparent.
		selTrack := ToElement new
			            border: (BlBorder paint: Color lightGray width: 1);
			size: 10 asPoint;
			            id: #'selection-track'.
		e isHorizontal
			ifTrue: [
				selTrack
					hMatchParent;
					vFitContent ]
			ifFalse: [
				selTrack
					hFitContent;
					vMatchParent ].
		e addChild: selTrack ]
]

{ #category : #'event handling' }
ToTabBarElementSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| selTrack |
		selTrack := e childWithId: #'selection-track'.
		selTrack removeFromParent ]
]
