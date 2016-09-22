all: EvalPoints.out

GMSH_ARGS=-clscale 0.1

plate.msh: plate.geo gf_rectangle.geo
	gmsh -2 plate.geo $(GMSH_ARGS)

plate1.msh: plate.geo gf_rectangle.geo
	gmsh -2 plate.geo -o plate1.msh $(GMSH_ARGS)

EvalPoints.out: EvalPoints parallel_plates.potentials plate.msh plate1.msh parallel_plates.scuffgeo parallel_plates.potentials
	scuff-static --Geometry parallel_plates.scuffgeo --PotentialFile parallel_plates.potentials --EPFile EvalPoints

clean:
	rm -f *.msh *.pp *.out *.log
