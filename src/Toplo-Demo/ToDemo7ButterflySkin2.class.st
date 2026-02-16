Class {
	#name : #ToDemo7ButterflySkin2,
	#superclass : #ToButterflySkin,
	#category : #'Toplo-Demo-2 - ButterflyTheme'
}

{ #category : #'event handling' }
ToDemo7ButterflySkin2 >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e border: Color blue.
		e padding: (BlInsets all: 15).
		e fitContent.
		e dem6 defaultButterflySkin: ToDemoButterflySkin2 new.
		e dem62 ensureCanManageToploSkin.
		e dem62 defaultButterflySkin: ToDemoButterflySkin1 new ]
]
