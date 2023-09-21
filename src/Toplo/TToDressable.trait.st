Trait {
	#name : #TToDressable,
	#category : 'Toplo-Core'
}

{ #category : #'t - dressable - accessing' }
TToDressable >> addDresser: aDresser [

	self dresser addDresser: aDresser in: self
]

{ #category : #'t - dressable -  initialization' }
TToDressable >> defaultDresser [

	^ ToNullDresser new
]

{ #category : #'t - dressable - accessing' }
TToDressable >> dresser [
	^ self userData at: #dresser ifAbsent: nil
]

{ #category : #'t - dressable - accessing' }
TToDressable >> dresser: aDresser [

	| currentDresser |
	currentDresser := self userData at: #dresser ifAbsent:[ nil ].
	(currentDresser notNil and:[ currentDresser = aDresser ]) ifTrue:[ ^ self ].

	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self userData at: #dresser put: aDresser.
	self dresserDo: [ :d | d launchInstallationIn: self ]
	
]

{ #category : #'t - dressable - accessing' }
TToDressable >> dresserDo: aBlock [

	self dresser ifNotNil: [ :d | aBlock cull: d ]
]

{ #category : #'t - dressable - accessing' }
TToDressable >> dresserSatisfying: aBlock [

	^ self dresser dresserSatisfying: aBlock
]

{ #category : #'t - dressable -  initialization' }
TToDressable >> initializeDresser [

	self dresser: self defaultDresser
]

{ #category : #'t - dressable -  initialization' }
TToDressable >> postInitializeDresser [
	"Called after dresser initialization"
	
]

{ #category : #'t - dressable -  initialization' }
TToDressable >> preInitializeDresser [
	"Called before dresser initialization"
	
]

{ #category : #'t - dressable - accessing' }
TToDressable >> removeDresser: aDresser [

	self dresser = aDresser ifFalse: [ 
		self dresser removeDresser: aDresser in: self.
		^ self ].
	self dresser: aDresser next.
	aDresser next: ToNullDresser new.
	aDresser launchUninstallationIn: self
]

{ #category : #'t - dressable - accessing' }
TToDressable >> undress [

	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self userData at: #dresser put: nil
]
