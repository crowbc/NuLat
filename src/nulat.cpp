#include <RAT/AnyParse.hh>
#include <RAT/Rat.hh>
#include <Nulat.hh>
#include <iostream>
#include <string>

int main(int argc, char **argv) {
  auto parser = new RAT::AnyParse(argc, argv);
  auto nulat = NULAT::Nulat(parser, argc, argv);
  nulat.Begin();
  nulat.Report();
}
